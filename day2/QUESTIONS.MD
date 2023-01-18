# Questions 🙋

1. **Who controls the ledger canister?**	
<br>The Network Nervous System (NNS) controls the ledger canister.
2. **What is the subnet of the canister with the id: `mwrha-maaaa-aaaab-qabqq-cai`? How much nodes are running this subnet?**
<br>The subnet of this canister is: `pae4o-o6dxf-xki7q-ezclx-znyd6-fnk6w-vkv5z-5lfwh-xym2i-otrrw-fqe` and has 16 nodes running according to [IC Network Status Dashboard](https://dashboard.internetcomputer.org/subnet/pae4o-o6dxf-xki7q-ezclx-znyd6-fnk6w-vkv5z-5lfwh-xym2i-otrrw-fqe).
3. **I have a neuron with 1O ICPs locked with a dissolve delay of 4 years - my neuron has been locked for 2 years. What is my expected voting power?**
<br>By linear interpolation we can now that the voting powers is multiplied by 1.498 due to the 4 years of dissolve delay, with the same technique we also can now that the voting power is multiplied by 1.125 due to the 2 years of locked time.
We also now that 1 ICP is 1 power of vote. So the expected voting power is: `10 * 1.498 * 1.125 = 14.23`.
4. **What is wrong with the following code?**
```motoko
actor {
  let n : Nat = 50;
  let t : Text = "Hello";

  public func convert_to_text(m : Nat) : async Text {
    Nat.toText(m);
  };
 
}
```
The error in the following code is that the import of Nat module is not specified. The correct code is:
```motoko
import Nat "mo:base/Nat";
// ...rest of the code...
```
5. What is wrong with the following code?
<br>The array of languages is not correctly declared, it should contain the `var` keyword before the first position of the array. i.e `[var "English", "German", "etc..."]` also a public function should not return a mutable array so we have to change the languages array to inmutable or freeze the languages array before returning it and remove the var keyword from the return type.
```
actor {
  var languages : [var Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func show_languages(language : Text) : async [var Text] {
    return (languages);
  };
 
}
```
6. What is wrong with the following code?
<br>We need to add the import of the library Array Module: `import Array "mo:base/Array"` also the append function is deprecated so we should use a Buffer instead an Array for that purpose.
```
actor {
  var languages : [Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func add_language(new_language: Text) : async [Text] {
    languages := Array.append<Text>(languages, [new_language]);
    return (languages);
  };
 
}
```