import Vue from "vue";
import VueRouter from "vue-router";
import { vuexOidcCreateRouterMiddleware } from "vuex-oidc";
import Home from "../views/Home.vue";
import Dashboard from "../views/Dashboard.vue";
import OidcCallback from "../components/OidcCallback";
import store from "../store";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: Home
  },
  {
    path: "/dashboard",
    name: "dashboard",
    component: Dashboard
  },
  {
    path: "/about",
    name: "about",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/About.vue")
  },
  {
    path: "/oidc-callback", // Needs to match redirectUri (redirect_uri if you use snake case) in you oidcSettings
    name: "oidcCallback",
    component: OidcCallback
  }
];

const router = new VueRouter({
  mode: "history",
  routes
});
router.beforeEach(vuexOidcCreateRouterMiddleware(store));
export default router;
