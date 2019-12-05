import Vue from "vue";
import Vuex from "vuex";
import { push } from "./push.module";
import { gbl } from "./gbl.module";
import { vuexOidcCreateStoreModule } from "vuex-oidc";

import { oidcSettings } from "./oidc";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    push,
    gbl,
    oidcStore: vuexOidcCreateStoreModule(oidcSettings, {
      publicRoutePaths: ["/", "/about"]
    })
  }
});
