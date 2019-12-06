<template>
  <vContainer>
    <h1>Jean-Pauvre simulator</h1>
    <v-btn color="success" @click="foo">blabla</v-btn>
    <SearchBar />
  </vContainer>
</template>

<script>
import SearchBar from "../components/SearchBar";
export default {
  name: "home",
  components: {
    SearchBar
  },
  methods: {
    foo() {
      this.$store.dispatch("setStale", true);
    }
  }
};
</script>
