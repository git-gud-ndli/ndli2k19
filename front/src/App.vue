<template>
  <v-app>
    <Navbar />
    <StaleAlert v-if="isStale" />
    <v-alert :type="alert.type" :value="alert.active">
      {{ alert.msg }}
    </v-alert>
    <v-content>
      <router-view></router-view>
    </v-content>
  </v-app>
</template>

<script>
import { mapGetters } from "vuex";
import Navbar from "./components/Navbar";
import StaleAlert from "./components/StaleAlert";

export default {
  name: "App",
  components: {
    Navbar,
    StaleAlert
  },

  data: () => ({}),
  computed: {
    ...mapGetters({
      isStale: "isStale",
      dark: "isDark",
      alert: "alert"
    })
  },
  created() {
    this.$store.restored.then(() => {
      this.$vuetify.theme.dark = this.dark;
    });
  }
};
</script>
<style lang="sass"></style>
