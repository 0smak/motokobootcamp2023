module Types {
	public type Artist = {
		id: Nat;
		name: Text;
		img: Text;
		proposals: [Proposal];
	};

	public type Proposal = {
		id: Nat;
		proposal: Text;
		votes: Nat;
	};

	public type ProposalArray = [Proposal];
	public type OptionalArtist = ?Artist;
	public type OptionalProposals = ?[Proposal];
	public type OptionalProposal = ?Proposal;
}
