<template>
  <div v-if="isDrizzleInitialized" id="app" class="max-w-7xl mx-auto mt-10">
    <header class="pb-10">
      <nav class="mx-4">
        <div class="w-full bg-gray-100 text-gray-900 font-bold flex justify-between pr-4 py-2 rounded-sm">
          <h1 class="text-gray-800 font-bold text-5xl"><span class="text-pink-700">Audio</span>DAPP</h1>
          <drizzle-account units="Ether" :precision="4" />
        </div>
      </nav>
    </header>

    <main class="text-gray-900 flex flex-col gap-7 mx-4">
      <div class="bg-gray-100 p-6 pt-9 rounded-sm">
        <h2 class="text-2xl font-bold">Upload your recording to the blockchain!</h2>
        <register-recording />
      </div>

      <div class="bg-gray-100 p-6 pt-9 rounded-sm">
      <record-list :key="componentKey" />
      </div>
    </main>

  </div>

  <div class="absolute top-1/2 left-1/2" v-else>
  <div></div>
    <svg class="animate-spin relative -ml-1 mr-3 h-20 w-20 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
    </svg>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import RegisterRecording from './components/RegisterRecording.vue'
import RecordList from './components/RecordList.vue'

export default {
  name: 'app',
  components: {
    RegisterRecording,
    RecordList,
  },
  computed: {
    ...mapGetters('drizzle', ['isDrizzleInitialized']),
    ...mapGetters('drizzle', ['drizzleInstance']),
  },
  data() {
    return {
      componentKey: 0,
    }
  },
  mounted: function () {
    this.$drizzleEvents.$on('drizzle/contractEvent', payload => {
      const { eventName, data } = payload;
      this.forceRerender();
    });
  },
  methods: {
    forceRerender() {
      this.componentKey += 1;
    },
  },
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
