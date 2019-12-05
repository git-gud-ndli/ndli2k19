import Vue from "vue";
import App from "./App.vue";
import "./registerServiceWorker";
import router from "./router";
import store from "./store";
import FetchWrapper from "./FetchWrapper";
import vuetify from "./plugins/vuetify";
import { createProvider } from "./vue-apollo";
window.api = new FetchWrapper();

Vue.config.productionTip = false;
let deferredPrompt = null;
window.addEventListener("beforeinstallprompt", e => {
  e.preventDefault();
  // Stash the event so it can be triggered later.
  deferredPrompt = e;
  console.log(deferredPrompt);
  // store.dispatch('notifications/setInstallPrompt', deferredPrompt)
});

window.addEventListener("appinstalled", () => {
  console.log("a2hs installed");
  // document.querySelector("#install-app-btn").style.display = "none";
});

Vue.filter("summary", function(text, stop, clamp) {
  if (!text) {
    return "";
  }
  return text.slice(0, stop) + (stop < text.length ? clamp || "..." : "");
});

new Vue({
  router,
  store,
  vuetify,
  apolloProvider: createProvider(),
  render: h => h(App)
}).$mount("#app");
