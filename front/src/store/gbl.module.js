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
      state.dark = val;
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
      commit("setTheme", !!val);
    },
    setStale: ({ commit }, val) => {
      commit("setStale", val);
    }
  },
  getters: {
    isLoading: state => state.loading,
    isStale: state => state.stale,
    isDark: state => state.dark
  }
};
