import Types "types";
import Utils "utils";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";

actor {
	stable var stableArtists : [(Text, Types.Artist)] = [];
	let artists = HashMap.fromIter<Text, Types.Artist>(
		stableArtists.vals(),
		10,
		Text.equal,
		Text.hash,
	);

	system func preupgrade() {
		stableArtists := Iter.toArray(artists.entries())
	};

	system func postupgrade() {
		stableArtists := []
	};

	public func exist_artist(id : ?Text) : async Bool {
		switch (id) {
			case null { false };
			case (?id) {
				switch (artists.get(id)) {
					case null { false };
					case (?id) { true }
				}
			}
		}
	};

	public shared ({ caller }) func add_artist(
		name : Text,
		img : Text,
		proposals : Types.ProposalArray,
	) : async () {
		switch (await exist_artist(?Principal.toText(caller))) {
			case (false) {
				create_new_artist(
					Principal.toText(caller),
					name,
					img,
					caller,
					proposals,
				)
			};
			case (true) {}
		}
	};

	private func create_new_artist(
		id : Text,
		name : Text,
		img : Text,
		caller : Principal,
		proposals : Types.ProposalArray,
	) : () {
		artists.put(
			id,
			{
				id = id;
				name = name;
				img = img;
				proposals = proposals;
				creator = caller
			},
		)
	};

	public func get_artists_count() : async Nat {
		return artists.size()
	};

	public func get_artists() : async [Types.Artist] {
		return Iter.toArray<Types.Artist>(artists.vals())
	};

	public func get_artist(id : Text) : async ?Types.Artist {
		return artists.get(id)
	};

	private func is_author(caller : Principal, artist_id : Text) : Bool {
		return Text.equal(Principal.toText(caller), artist_id)
	};

	public shared ({ caller }) func update_artist(
		id : Text,
		name : Text,
		img : Text,
		proposals : Types.ProposalArray,
	) : async () {
		if (is_author(caller, id) == false) {
			// should throw error
		} else {
			switch (await exist_artist(?Principal.toText(caller))) {
				case (true) {
					create_new_artist(
						Principal.toText(caller),
						name,
						img,
						caller,
						proposals,
					)
				};
				case (false) {}
			}
		}
	};

	public shared ({ caller }) func delete_artist(id : Text) : async () {
		if ((await exist_artist(?id)) and is_author(caller, id)) {
			ignore artists.remove(id)
		}
	};

	public func get_artist_proposals(id : Text) : async Types.ProposalArray {
		let artist : ?Types.Artist = (await get_artist(id));
		switch (artist) {
			case null { [] };
			case (?artist) { artist.proposals }
		}
	};

	private func get_proposal_index(proposals : Buffer.Buffer<Types.Proposal>, proposalId : Nat) : ?Nat {
		let equal : (Types.Proposal, Nat) -> Bool = func(x : Types.Proposal, y : Nat) : Bool {
			x.id == y
		};
		return Utils.find_index<Types.Proposal, Nat>(proposals, proposalId, equal)
	};

	public func get_artist_proposal(artistId : Text, proposalId : Nat) : async Types.OptionalProposal {
		let proposals : [Types.Proposal] = (await get_artist_proposals(artistId));
		let index : ?Nat = get_proposal_index(Buffer.fromArray<Types.Proposal>(proposals), proposalId);
		switch (index) {
			case null { null };
			case (?index) { ?proposals[index] }
		}
	};

	private func manipulate_artist_proposal(artistId : Text, action : (proposals : Buffer.Buffer<Types.Proposal>) -> ()) : async () {
		let artist : ?Types.Artist = (await get_artist(artistId));
		switch (artist) {
			case null {};
			case (?artist) {
				var proposals_array : Types.ProposalArray = (await get_artist_proposals(artistId));
				let proposals : Buffer.Buffer<Types.Proposal> = Buffer.fromArray<Types.Proposal>(proposals_array);
				action(proposals);
				proposals_array := Buffer.toArray<Types.Proposal>(proposals);
				(await update_artist(artist.id, artist.name, artist.img, proposals_array))
			}
		}
	};

	public shared ({ caller }) func add_artist_proposal(artistId : Text, new_proposal : Types.Proposal) : async () {
		if (is_author(caller, artistId)) {
			await manipulate_artist_proposal(
				artistId,
				func(proposals : Buffer.Buffer<Types.Proposal>) {
					proposals.add(new_proposal)
				},
			)
		}
	};

	public shared ({ caller }) func update_artist_proposal(artistId : Text, proposal : Types.Proposal) : async () {
		if (is_author(caller, artistId)) {
			await manipulate_artist_proposal(
				artistId,
				func(proposals : Buffer.Buffer<Types.Proposal>) {
					let index : ?Nat = get_proposal_index(proposals, proposal.id);
					switch (index) {
						case null {};
						case (?index) {
							proposals.put(index, proposal)
						}
					}
				},
			)
		}
	};

	public shared ({ caller }) func delete_artist_proposal(artistId : Text, proposalId : Nat) : async () {
		if (is_author(caller, artistId)) {

			await manipulate_artist_proposal(
				artistId,
				func(proposals : Buffer.Buffer<Types.Proposal>) {
					let index : ?Nat = get_proposal_index(proposals, proposalId);
					switch (index) {
						case null {};
						case (?index) {
							ignore proposals.remove(proposalId)
						}
					}
				},
			)
		}
	}
}
