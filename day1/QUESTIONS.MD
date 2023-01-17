# 🙋 Questions

1. **How much is the current memory capacity of a canister?**

   4GB is the maximum memory capacity of a canister.

2. **What is the issue with the following code sample?**

```
actor {
  let counter : Nat = 0;
  public func increment_counter() : async () {
    counter := counter + 1;
  };
}
```

In this code example you cannot reassign a value to a `let` variable. You can only assign a value to a `var` variable. Due to `let` variables are not mutable.

1. **What is the issue with the following code sample?**

```
actor {
  var message : Text = 0;

  public query func change_message(new_message : Text) : async () {
    message := new_message;
    return;
  };

  public query func see_message() : async Text {
    return(message);
  };
}
```

You cannot assign a number to a `Text` variable. You can only assign a `Text` value to a `Text` variable.

4.  **False or True: we can remove the keyword **async** for return argument of a query function since queries are faster to answer.**
