<template>
  <header class="flex justify-evenly py-7 bg-gray-900
  text-yellow-50 font-bold justify-center">
    <nav>
      <ul class="flex gap-4">
        <li class="hover:text-purple-400 transition">
          <router-link to="/">Home</router-link>
        </li>
        <li class="hover:text-purple-400 transition">
          <router-link to="/marketplace">Marketplace</router-link>
        </li>
      </ul>
    </nav>
    <div class="float-right">Connect</div>
  </header>
  <main class="text-gray-100 bg-gray-800 flex flex-col h-screen">
    <div class="my-16 mx-6 md:mx-16 xxl:mx-64">
      <router-view/>
    </div>
  </main>
  <footer class="bg-gray-800 text-gray-100">
    <hr class="opacity-25 mx-36">
    <sm class="pt-16 pb-8 flex justify-center font-light text-sm opacity-80">rz18025 @2022</sm>
  </footer>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
