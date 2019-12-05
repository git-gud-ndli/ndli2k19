import Vue from "vue";
import Vuex from "vuex";
import VuexPersist from "vuex-persist";
import localforage from "localforage";
import { push } from "./push.module";
import { gbl } from "./gbl.module";
import { vuexOidcCreateStoreModule } from "vuex-oidc";

import { oidcSettings } from "./oidc";

const vuexLocalStorage = new VuexPersist({
  key: "vuex",
  storage: localforage,
  asyncStorage: true,
  modules: ["gbl"]
});

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    push,
    gbl,
    oidcStore: vuexOidcCreateStoreModule(oidcSettings, {
      publicRoutePaths: ["/", "/about"]
    })
  },
  plugins: [vuexLocalStorage.plugin]
});
