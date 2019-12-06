<template>
  <v-container>
    <v-row> </v-row>
    <v-row>
      <SearchBar @up-search="updateTags" />
    </v-row>
  </v-container>
</template>
<script>
import SearchBar from "../components/SearchBar";
export default {
  name: "tag-search-container",
  components: {
    SearchBar
  },
  data() {
    return {
      tagsAppliques: []
    };
  },
  methods: {
    updateTags(val) {
      this.tagsAppliques = val;
    }
  }
};
</script>
