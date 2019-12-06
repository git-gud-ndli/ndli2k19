<template>
  <v-container style="margin: 50px auto;">
    <v-row style="justify-content: space-evenly">
      <Bulle v-for="(tag, i) in tagsTendances" :key="i" :title="tag" style="width:200px;height:200px" />
    </v-row>
    <v-row style="margin-top:100px">
      <SearchBar :items="items" />
    </v-row>
  </v-container>
</template>
<script>
import Bulle from "../components/Bulle"
import SearchBar from "../components/SearchBar"

export default {
  name: "TagSearchContainer",
  data() {
      return {
          tagsTendances: ["lkjjjl", "ljjkljlk", "kjvczbkczbcz"],
          tagsAppliques: [],
          items: ["test", "kljjkh"]
      }
  },
  components: {
    Bulle,
    SearchBar
  }
};
</script>