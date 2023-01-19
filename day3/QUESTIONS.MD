# Questions 🙋
### 1. **True or False: the Internet Computer has a unique public key that can be used to verify responses coming from any subnets.**
True; the response served is signed under the public key of the IC.

---
### **2. True or False: when I realize an update call, the boundary node will participate in the consensus but not during query calls.**
True, on update calls, the boundary node will participate in the consensus, but not during query calls, but we can solve this using certified variables.

---
### **3. True or False: I can create a certified variable that will certify the response of the following actor:**
False, you should not be able to create a certified variable that will certify the response of the actor
```
actor {
    public func hello(name : Text) : async Text {
        return ("hello # name");
    };
}
```