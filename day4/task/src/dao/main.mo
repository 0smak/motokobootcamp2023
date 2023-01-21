import Types "types";
import Utils "utils";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Iter "mo:base/Iter";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";

actor {
	stable var stableArtists : [(Nat, Types.Artist)] = [];
	let artists = HashMap.fromIter<Nat, Types.Artist>(
		stableArtists.vals(),
		10,
		Nat.equal,
		Hash.hash,
	);

	system func preupgrade() {
		stableArtists := Iter.toArray(artists.entries())
	};

	system func postupgrade() {
		stableArtists := []
	};

	public func exist_artist(id : Nat) : async Bool {
		switch (artists.get(id)) {
			case null { false };
			case (?id) { true }
		}
	};

	public func add_artist(artist : Types.Artist) : async () {
		switch (artists.get(artist.id)) {
			case null {
				artists.put(artist.id, artist)
			};
			case (?id) {}
		}
	};

	public func get_artists_count() : async Nat {
		return artists.size()
	};

	public func get_artists() : async [Types.Artist] {
		return Iter.toArray<Types.Artist>(artists.vals())
	};

	public func get_artist(id : Nat) : async ?Types.Artist {
		return artists.get(id)
	};

	public func update_artist(artist : Types.Artist) : async () {
		switch (artists.get(artist.id)) {
			case null {};
			case (?id) {
				artists.put(artist.id, artist)
			}
		}
	};

	public func delete_artist(id : Nat) : async () {
		if (await exist_artist(id)) {
			ignore artists.remove(id)
		}
	};

	public func get_artist_proposals(id : Nat) : async Types.ProposalArray {
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

	public func get_artist_proposal(artistId : Nat, proposalId : Nat) : async Types.OptionalProposal {
		let proposals : [Types.Proposal] = (await get_artist_proposals(artistId));
		let index : ?Nat = get_proposal_index(Buffer.fromArray<Types.Proposal>(proposals), proposalId);
		switch (index) {
			case null { null };
			case (?index) { ?proposals[index] }
		}
	};

	private func manipulate_artist_proposal(artistId : Nat, action : (proposals : Buffer.Buffer<Types.Proposal>) -> ()) : async () {
		let artist : ?Types.Artist = (await get_artist(artistId));
		switch (artist) {
			case null {};
			case (?artist) {
				var proposals_array : Types.ProposalArray = (await get_artist_proposals(artistId));
				let proposals : Buffer.Buffer<Types.Proposal> = Buffer.fromArray<Types.Proposal>(proposals_array);
				action(proposals);
				proposals_array := Buffer.toArray<Types.Proposal>(proposals);
				(await update_artist({ id = artist.id; name = artist.name; img = artist.img; proposals = proposals_array }))
			}
		}
	};

	public func add_artist_proposal(artistId : Nat, new_proposal : Types.Proposal) : async () {
		await manipulate_artist_proposal(
			artistId,
			func(proposals : Buffer.Buffer<Types.Proposal>) {
				proposals.add(new_proposal)
			},
		)
	};

	public func update_artist_proposal(artistId : Nat, proposal : Types.Proposal) : async () {
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
	};

	public func delete_artist_proposal(artistId : Nat, proposalId : Nat) : async () {
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
