<script>
  import Home from "./components/Home.svelte"
  import ConnectButton from "./components/shared/ConnectButton.svelte"
  import { view } from "./stores.js"
</script>

<div class="App">
    <ConnectButton />
  <div class="main">
    {#if $view.current === $view.home}
      <Home />
    {/if}
  </div>

</div>

<style global>

body {
  width: 100%;
  min-height: 100vh;
  margin: 0;

  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
}

.main {
  height: 100vh;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 32px;  
}

</style>
