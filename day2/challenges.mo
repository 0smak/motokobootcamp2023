import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Buffer "mo:base/Buffer";

actor {
	// 1. Write a function average_array that takes an array of integers and returns the average value of the elements in the array.
	public func average_array(array: [Int]) : async Int {
		var sum: Int = 0;
		for (n in array.vals()) {
			sum += n;
		};
		return sum / array.size();
	};

	// 2. Character count: Write a function that takes in a string and a character, and returns the number of occurrences of that character in the string.
	public func count_character(t : Text, c : Char) : async Nat {
		var count: Nat = 0;
		for (char in t.chars()) {
			if (char == c) {
				count += 1;
			};
		};
		return count;
	};

	// 3. Write a function factorial that takes a natural number n and returns the factorial of n.
	func factorial(n : Nat) : async Nat {
		if (n == 0) {
			return 1;
		} else {
			return n * (await factorial(n - 1));
		};
	};

	// 4. Write a function number_of_words that takes a sentence and returns the number of words in the sentence.
	public func number_of_words(t : Text) : async Nat {
		var count: Nat = 0;
		if (t.size() > 0) {
			count += 1;
		};
		for (word in t.chars()) {
			if (word == ' ') {
				count += 1;
			};
		};
		return count;
	};

	// 5. Write a function find_duplicates that takes an array of natural numbers and returns a new array containing all duplicate numbers. The order of the elements in the returned array should be the same as the order of the first occurrence in the input array.
	public func is_on_array(a: [Nat], n: Nat) : async Bool {
		for (num in a.vals()) {
			if (num == n) {
				return true;
			};
		};
		return false;
	};

	public func is_duplicated(a: [Nat], n: Nat) : async Bool {
		var count: Nat = 0;
		for (num in a.vals()) {
			if (num == n) {
				count += 1;
			};
			if (count > 1) {
				return true;
			};
		};
		return count > 1;
	};
	
	public func find_duplicates(a: [Nat]) : async [Nat] {
		var duplicates : [Nat] = [];
		var seen : [Nat] = [];
		for (n in a.vals()) {
			if ((await is_on_array(seen, n)) != false and (await is_duplicated(a, n))) {
				duplicates := Array.append<Nat>(duplicates, [n]);
			};
			seen := Array.append<Nat>(seen, [n]);
		};
		return duplicates;
	};

	// 6. Write a function convert_to_binary that takes a natural number n and returns a string representing the binary representation of n.
	public func convert_to_binary(n : Nat) : async Text {
		if (n == 0) {
			return "0";
		} else {
			return (await convert_to_binary(n / 2)) # Nat.toText(n % 2);
		};
	};
}

