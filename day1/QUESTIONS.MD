# 🙋 Questions

1. **How much is the current memory capacity of a canister?**

   4GB is the maximum memory capacity of a canister.

2. **What is the issue with the following code sample?**

   In this code example you cannot reassign a value to a `let` variable. You can only assign a value to a `var` variable. Due to `let` variables are not mutable.

   ```
   actor {
     let counter : Nat = 0;
     public func increment_counter() : async () {
       counter := counter + 1;
     };
   }
   ```

3. **What is the issue with the following code sample?**

   You cannot assign a number to a `Text` variable. You can only assign a `Text` value to a `Text` variable.

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

4. **False or True: we can remove the keyword **async** for return argument of a query function since queries are faster to answer.**

   False, we cannot remove the keyword `async` for return argument because the result is always delayed.
