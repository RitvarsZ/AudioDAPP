import { provideFluentDesignSystem, fluentCard, fluentButton } from '@fluentui/web-components';
import './index.css';
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';

createApp(App).use(store).use(router).mount('#app');
provideFluentDesignSystem().register(
  fluentCard(),
  fluentButton(),
);
