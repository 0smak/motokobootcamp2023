import Array "mo:base/Array";
import Option "mo:base/Option";
import {compare} "mo:base/Int";
import {Buffer} "mo:base/Buffer";

module Utils  {
	public func second_maximum(array: [Int]) : Int {
		let sorted = Array.sort(array, compare);
		return sorted[1];
	};

	public func remove_even(array: [Nat]) : [Nat] {
		return Array.filter(array, func (x: Nat) : Bool {
			return x % 2 == 1;
		});
	};

	public func drop<T>(xs: [T], n: Nat) : [T] {
		if (xs.size() <= n) return [];
		var i = 0;
		return Array.filter<T>(xs, func _ {
			i += 1;
			return (i > n);
		});
	}
}