import localforage from "localforage";
import store from "./store";

const manualQueueMaxDelay = 1; // 1 day
const addDays = (date, days) => {
  let result = new Date(date);
  result.setDate(result.getDate() + days);
  return result;
};

export default class FetchWrapper {
  constructor() {
    this.config = {
      headers: new Headers({
        "Content-Type": "application/json",
        Accept: "application/json"
      }),
      mode: "cors",
      cache: "default"
    };
    this.token = "";
    this.base_url = process.env.VUE_APP_API_ENDPOINT;
    this.syncQueue = localforage.createInstance({
      // when bg-sync is not supported
      driver: localforage.INDEXEDDB,
      name: "manual-sync-queue",
      storeName: "manual-sync-queue"
    });
  }

  setAuthorizationToken(token) {
    this.token = token;
    this.config.headers.set("Authorization", `Bearer ${token}`);
  }

  removeAuthorizationToken() {
    this.token = "";
    this.config.headers.delete("Authorization");
  }

  get(endpoint) {
    return new Promise((resolve, reject) => {
      fetch(`${this.base_url}${endpoint}`, this.config)
        .then(async response => {
          if (!response.ok) {
            let data = await response.json();
            if (response.status === 401) {
              store.dispatch("auth/logout", true);
            }
            reject({ status: response.status, data });
          } else {
            resolve(response.json());
          }
        })
        .catch(data => {
          reject({ data });
        });
    });
  }

  // Returns a new promise to handle like with Axios
  post(endpoint, payload) {
    return new Promise((resolve, reject) => {
      fetch(`${this.base_url}${endpoint}`, {
        method: "POST",
        body: JSON.stringify(payload),
        ...this.config
      })
        .then(async response => {
          if (!response.ok) {
            let data = await response.json();
            if (response.status === 401) {
              store.dispatch("auth/logout", true);
            }
            reject({ status: response.status, data });
          } else {
            resolve(response.json());
          }
        })
        .catch(data => {
          reject({ data });
        });
    });
  }

  processManualQueue() {
    let now = new Date();
    this.syncQueue.iterate((val, key) => {
      let params = key.split("-");
      this.post(params[0], { ...val, deferred: true })
        .then(() => {
          console.log("removing", key);
          this.syncQueue.removeItem(key);
        })
        .catch(() => {
          let maxTimeout = addDays(new Date(params[1]), manualQueueMaxDelay);
          if (maxTimeout < now) {
            console.log("removing", key, "(timeout)");
            this.syncQueue.removeItem(key);
          }
        });
    });
  }
}
