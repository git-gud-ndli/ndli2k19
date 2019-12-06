import localforage from "localforage";
// import ApolloClient from "apollo-boost";
import Vue from "vue";
import { base64DecToArr } from "../helpers";
import gql from "graphql-tag";

// const apolloClient = new ApolloClient({
//   // You should use an absolute URL here
//   uri: process.env.VUE_APP_GRAPHQL_HTTP || "http://localhost:3000/graphql"
// });

const configurePushSub = sub => {
  console.log("sub", sub);
  // eslint-disable-next-line
  if (sub) {
    const key = sub.getKey("p256dh");
    const token = sub.getKey("auth");
    const contentEncoding = (PushManager.supportedContentEncodings || [
      "aesgcm"
    ])[0];
    console.log("pojj");
    // eslint-disable-next-line
    // return api.post("/push/subscribe", {
    //   endpoint: sub.endpoint,
    //   publicKey: key
    //     ? btoa(String.fromCharCode.apply(null, new Uint8Array(key)))
    //     : null,
    //   authToken: token
    //     ? btoa(String.fromCharCode.apply(null, new Uint8Array(token)))
    //     : null,
    //   contentEncoding
    // });
    return Vue.prototype.$apollo.mutate({
      mutation: gql`
        mutation registerPush($e: String!) {
          addDevice(input: { endpoint: $e }) {
            clientMutationId
          }
        }
      `,
      variables: {
        e: sub.endpoint,
        key: key,
        token: token
      }
    });
  }
  return navigator.serviceWorker.ready
    .then(reg => {
      console.log("barbar");
      // convert VAPID public key
      let publicKey = base64DecToArr(process.env.VUE_APP_VAPID_KEY);
      let foo = reg.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: publicKey
      });
      console.log(foo);
      return foo;
    })
    .then(newSub => {
      console.log(newSub);
      const key = newSub.getKey("p256dh");
      const token = newSub.getKey("auth");
      const contentEncoding = (PushManager.supportedContentEncodings || [
        "aesgcm"
      ])[0];
      console.log(key, token, contentEncoding);
      // eslint-disable-next-line
      return Vue.prototype.$apollo.mutate({
        mutation: gql`
          mutation registerPush($e: String!) {
            addDevice(input: { endpoint: $e }) {
              clientMutationId
            }
          }
        `,
        variables: {
          e: newSub.endpoint,
          key: key,
          token: token
        }
      });
    });
};

const unsubscribeToPush = () => {
  return navigator.serviceWorker.ready
    .then(reg => reg.pushManager.getSubscription())
    .then(async sub => {
      let { endpoint } = sub;
      await sub.unsubscribe();
      // eslint-disable-next-line
      return api.post("/push/unsubscribe", { endpoint });
    });
};

export const push = {
  namespaced: true,
  state: {
    pushEnabled: false
  },
  mutations: {
    setPush: (state, value) => {
      state.pushEnabled = !!value;
    }
  },
  actions: {
    checkPushPermission: ({ dispatch }) => {
      localforage.getItem("push_enabled").then(val => {
        if (val === true) {
          dispatch("setPushStatus", true);
        }
      });
    },
    setPushStatus: ({ commit }, value) => {
      if (!("Notification" in window && navigator.serviceWorker)) {
        // unsupported
        commit("setPush", false);
        localforage.setItem("push_enabled", false);
      }
      // eslint-disable-next-line
      if (true) {
        if (value) {
          Notification.requestPermission().then(async value => {
            // permission granted
            if (value === "granted") {
              let sub = await navigator.serviceWorker.ready.then(reg => {
                return reg.pushManager.getSubscription();
              });
              if (sub) {
                commit("setPush", true);
              }
              console.log("issou", sub);
              configurePushSub(sub)
                .then(() => {
                  console.log("bla");
                  commit("setPush", true);
                  localforage.setItem("push_enabled", true);
                })
                .catch(() => {});
            }
          });
        } else {
          unsubscribeToPush()
            .then(() => {
              commit("setPush", false);
              localforage.setItem("push_enabled", false);
            })
            .catch(() => {});
        }
      }
    }
  },
  getters: {
    push: state => state.pushEnabled
  }
};
