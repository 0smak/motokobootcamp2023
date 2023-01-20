import List "mo:base/List";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Blob "mo:base/Blob";

actor {

	let usernames = HashMap.HashMap<Principal, Text>(0, Principal.equal, Principal.hash);

	func unique<T>(l : List.List<T>, equal: (T,T) -> Bool) : List.List<T> {
		let buffer : Buffer.Buffer<T> = Buffer.fromArray<T>(List.toArray(l));
		let uniques	: Buffer.Buffer<T> = Buffer.Buffer<T>(buffer.size());
		for (b in buffer.vals()) {
			if (Buffer.contains(uniques, b, equal) == false) {
				uniques.add(b);
			};
		};
		return List.fromArray(Buffer.toArray<T>(buffer));	
	};

	func reverse<T>(l : List.List<T>) : List.List<T> {
		let a : [var T] = Array.thaw(List.toArray(l));
		if (a.size() == 0) {
			return l;
		};
		var index : Nat = a.size() - 1;
		List.iterate(l, func (x : T) {
			if (index >= 0) {
				a[index] := x;
				if (index > 0) index -= 1;
			}
		});
		return List.fromArray(Array.freeze(a));
	};

	public shared ({caller}) func is_anynomous() : async Bool {
		return Principal.isAnonymous(caller);
	};

	func find_in_buffer<T>(buf: Buffer.Buffer<T>, val: T, equal: (T,T) -> Bool) : ?Nat {
		var index : Nat = 0;
		for (b in buf.vals()) {
			if (equal(b, val)) {
				return ?index;
			};
			index += 1;
		};
		return null;
	};

	public shared ({ caller }) func add_username(name : Text) : async () {
		usernames.put(caller, name);
	};

	public shared ({ caller }) func get_usernames() : async [(Principal, Text)] {
		return Iter.toArray<(Principal, Text)>(usernames.entries());
	};
}
