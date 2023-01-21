import Principal "mo:base/Principal";
module Types {
	public type Artist = {
		id : Text;
		creator : Principal;
		name : Text;
		img : Text;
		proposals : [Proposal]
	};

	public type Proposal = {
		id : Nat;
		proposal : Text;
		votes : Nat
	};

	public type ProposalArray = [Proposal];
	public type OptionalArtist = ?Artist;
	public type OptionalProposals = ?[Proposal];
	public type OptionalProposal = ?Proposal
}
