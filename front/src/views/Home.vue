<template>
  <div class="home">
    <h1>Jean-Pauvre simulator</h1>
    <v-btn color="success" @click="foo">blabla</v-btn>
  </div>
</template>

<script>
export default {
  name: "home",
  components: {},
  methods: {
    foo() {
      this.$store.dispatch("setStale", true);
    }
  }
};
</script>
