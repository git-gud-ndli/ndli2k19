<template>
  <v-container style="margin: 50px auto;">
    <v-row style="justify-content: space-evenly">
      <Bulle
        v-for="(tag, i) in tagsTendances"
        :key="i"
        :title="tag"
        style="width:200px;height:200px"
      />
    </v-row>
    <v-row style="margin-top:100px">
      <SearchBar @up-search="updateTags" style="width:100%;" />
    </v-row>
  </v-container>
</template>
<script>
import SearchBar from "../components/SearchBar";
import Bulle from "../components/Bulle";
export default {
  name: "tag-search-container",
  components: {
    SearchBar,
    Bulle
  },
  props: {
    tagsAppliques: Array
  },
  data() {
    return {
      tagsTendances: ["lkjjjl", "ljjkljlk", "kjvczbkczbcz"]
    };
  },
  methods: {
    updateTags(val) {
      this.tagsAppliques = val;
    }
  }
};
</script>
