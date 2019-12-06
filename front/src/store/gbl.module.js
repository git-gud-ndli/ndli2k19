export const gbl = {
  state: {
    loading: false,
    dark: false,
    stale: false,
    alert: {
      type: "",
      msg: "",
      active: false
    }
  },
  mutations: {
    setLoading: (state, val) => {
      state.loading = val;
    },
    setTheme: (state, val) => {
      state.dark = val;
    },
    setStale: (state, val) => {
      state.stale = val;
    },
    setNotification: (state, { type, msg }) => {
      state.alert.type = type;
      state.alert.msg = msg;
      state.alert.active = true;
    },
    dismissAlert: state => {
      state.alert.active = false;
    }
  },
  actions: {
    setLoading: ({ commit }, val) => {
      commit("setLoading", !!val);
    },
    setTheme: ({ commit }, val) => {
      commit("setTheme", !!val);
    },
    setStale: ({ commit }, val) => {
      commit("setStale", val);
    },
    setNotification: ({ commit }, payload) => {
      commit("setNotification", payload);
    },
    dismissAlert: ({ commit }) => {
      commit("dismissAlert");
    }
  },
  getters: {
    isLoading: state => state.loading,
    isStale: state => state.stale,
    isDark: state => state.dark,
    alertActive: state => state.alert.active,
    alert: state => state.alert
  }
};
