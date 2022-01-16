<template>
  <div v-if="isDrizzleInitialized" id="app" class="max-w-7xl mx-auto mt-10">
    <div class="section">
      <h2>Show the Accounts</h2>
      <drizzle-account units="Ether" :precision="2" />
    </div>

    <div class="section">
      <h2>Tutorial Token</h2>
    </div>
  </div>

  <div v-else>
    <div>Loading</div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'app',
  components: {
  },

  computed: mapGetters('drizzle', ['isDrizzleInitialized'])
}
</script>

<style>
body {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #fafafa;
}
</style>
