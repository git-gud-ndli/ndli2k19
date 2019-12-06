<template>
  <div>
    <v-app-bar color="rgb(255,255,255,0)" absolute flat>
      <v-app-bar-nav-icon color="white"></v-app-bar-nav-icon>
      <v-toolbar-title class="white--text" v-if="oidcUser">
        {{ oidcUser.name }}
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn v-if="oidcUser" @click="logout" text color="white">
        Log Out
      </v-btn>
      <v-btn :to="{ name: 'dashboard' }" text color="white">My Account</v-btn>
      <SettingsMenu />
      <v-avatar v-if="oidcUser" size="36px" class="ml-5">
        <img alt="Avatar" :src="oidcUser.picture" />
      </v-avatar>
    </v-app-bar>
  </div>
</template>
<script>
import { mapGetters } from "vuex";
import SettingsMenu from "../components/SettingsMenu";

export default {
  data() {
    return {};
  },
  components: {
    SettingsMenu
  },
  computed: {
    ...mapGetters(["oidcUser"])
  },
  methods: {
    logout() {
      this.$store.dispatch("removeOidcUser").then(() => {
        this.$router.push({ name: "home" });
      });
    }
  }
};
</script>
