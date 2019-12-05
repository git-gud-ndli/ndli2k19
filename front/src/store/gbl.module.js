export const gbl = {
  state: {
    loading: false,
    dark: false,
    stale: false
  },
  mutations: {
    setLoading: (state, val) => {
      state.loading = val;
    },
    setTheme: (state, val) => {
      state.theme = val;
    },
    setStale: (state, val) => {
      state.stale = val;
    }
  },
  actions: {
    setLoading: ({ commit }, val) => {
      commit("setLoading", !!val);
    },
    setTheme: ({ commit }, val) => {
      if (val === "dark") {
        commit("setTheme", true);
      }
    },
    setStale: ({ commit }, val) => {
      commit("setStale", val);
    }
  },
  getters: {
    isLoading: state => state.loading,
    isStale: state => state.stale
  }
};
