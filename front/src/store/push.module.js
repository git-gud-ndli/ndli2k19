import localforage from "localforage";
import { base64DecToArr } from "../helpers";

const configurePushSub = sub => {
  if (sub) {
    const key = sub.getKey("p256dh");
    const token = sub.getKey("auth");
    const contentEncoding = (PushManager.supportedContentEncodings || [
      "aesgcm"
    ])[0];
    // eslint-disable-next-line
    return api.post("/push/subscribe", {
      endpoint: sub.endpoint,
      publicKey: key
        ? btoa(String.fromCharCode.apply(null, new Uint8Array(key)))
        : null,
      authToken: token
        ? btoa(String.fromCharCode.apply(null, new Uint8Array(token)))
        : null,
      contentEncoding
    });
  }
  return navigator.serviceWorker.ready
    .then(reg => {
      // convert VAPID public key
      let publicKey = base64DecToArr(process.env.VUE_APP_VAPID_KEY);
      return reg.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: publicKey
      });
    })
    .then(newSub => {
      const key = newSub.getKey("p256dh");
      const token = newSub.getKey("auth");
      const contentEncoding = (PushManager.supportedContentEncodings || [
        "aesgcm"
      ])[0];
      // eslint-disable-next-line
      return api.post("/push/subscribe", {
        endpoint: newSub.endpoint,
        publicKey: key
          ? btoa(String.fromCharCode.apply(null, new Uint8Array(key)))
          : null,
        authToken: token
          ? btoa(String.fromCharCode.apply(null, new Uint8Array(token)))
          : null,
        contentEncoding
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
          console.log("hooo");
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
      if (api.token) {
        if (value) {
          Notification.requestPermission().then(async value => {
            // permission granted
            if (value === "granted") {
              let sub = await navigator.serviceWorker.ready.then(reg => {
                return reg.pushManager.getSubscription();
              });
              if (sub) {
                commit("setPush", true);
                console.log("Already subscribed to Push");
              }
              configurePushSub(sub)
                .then(data => {
                  console.log(data);
                  commit("setPush", true);
                  localforage.setItem("push_enabled", true);
                })
                .catch(err => {
                  console.error(err);
                });
            }
          });
        } else {
          unsubscribeToPush()
            .then(data => {
              console.log(data);
              commit("setPush", false);
              localforage.setItem("push_enabled", false);
            })
            .catch(err => {
              console.error(err);
            });
        }
      }
    }
  },
  getters: {
    push: state => state.pushEnabled
  }
};
