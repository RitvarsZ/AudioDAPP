import './index.css'
import Vue from 'vue'
import App from './App.vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

// Todo: Update this when publishing
// import drizzleVuePlugin from '@drizzle/vue-plugin'
//
import drizzleVuePlugin from '@drizzle/vue-plugin'
import drizzleOptions from './drizzleOptions'

Vue.use(Vuex)
const store = new Vuex.Store({
  state: {
    records: []
  },
  mutations: {
    addRecord (state, record) {
      state.records.push(record)
    }
  },
  plugins: [createPersistedState()],
});

Vue.use(drizzleVuePlugin, { store, drizzleOptions })

Vue.config.productionTip = false

new Vue({
  store,
  render: h => h(App)
}).$mount('#app')
