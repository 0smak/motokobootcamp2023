# <a id="questions"> 🙋 Questions </a>

1. ### **True or False: we can prevent the heap being erased during upgrades by using a `stable` heap.**

True, we can prevent the heap being erased always if the type of the variable can be stable, in example, a class cannot be stable

2. ### **`A.call() -> B.call() -> C` How much time (or rounds of consensus) do we need to wait for an answer?**

If the canisters are on the same subnet, you will need 2 rounds of consensus, one round is equivalent to 2 seconds, so 2\*2 = 4 seconds. If the canisters are on different subnets, you will need 4 rounds of consensus, so 4\*2 = 8 seconds.

3. ### **Is possible to realize an intercanister call in query mode?**

Yes, it is possible
