import Buffer "mo:base/Buffer";
module Utils {
	public func find_index<T, U>(a : Buffer.Buffer<T>, val : U, equal : (T, U) -> Bool) : ?Nat {
		var index : Nat = 0;
		for (el in a.vals()) {
			if (equal(el, val)) return ?index;
			index += 1
		};
		return null
	}
}
