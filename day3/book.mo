module Book {
	public type Book = {
		title: Text;
		pages: Nat;
	};

	public func create_book(title : Text, pages : Nat) : Book {
		return { title ; pages };
	};
};
