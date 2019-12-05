export const gbl = {
  state: {
    loading: false,
    dark: false
  },
  actions: {
    setLoading: ({ commit }, val) => {
      commit("setLoading", !!val);
    },
    setTheme: ({ commit }, val) => {
      if (val === "dark") {
        commit("setTheme", true);
      }
    }
  },
  mutations: {
    setLoading: ({ state }, val) => {
      state.loading = val;
    },
    setTheme: ({ state }, val) => {
      state.theme = val;
    }
  },
  getters: {
    isLoading: state => state.loading
  }
};
