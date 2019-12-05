<template>
  <v-container grid-list-xs class="text-center">
    <h2>Here we go</h2>
    <v-progress-circular
      indeterminate
      :size="128"
      color="primary"
    ></v-progress-circular>
  </v-container>
</template>

<script>
import { mapActions } from "vuex";

export default {
  name: "OidcCallback",
  methods: {
    ...mapActions(["oidcSignInCallback"])
  },
  mounted() {
    this.oidcSignInCallback()
      .then(redirectPath => {
        this.$router.push(redirectPath);
      })
      .catch(err => {
        console.error(err);
        this.$router.push("/oidc-callback-error"); // Handle errors any way you want
      });
  }
};
</script>
