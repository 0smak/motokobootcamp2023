import Book "book";
import List "mo:base/List";

actor {
	let my_book : Book.Book = {
		title = "The C Programming Language";
		pages = 234;
	};

	let my_libray : List.List<Book.Book> = List.nil<Book.Book>();

	public func add_book(book: Book.Book): async () {
		ignore List.push(book, my_libray);
	};

	public func get_books(): async [Book.Book] {
		return List.toArray(my_libray);
	};
}

