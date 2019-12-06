<template>
  <div>
    <v-autocomplete
      v-if="tags"
      :items="tags.nodes"
      item-text="name"
      item-value="tagId"
      label="Que cherchez-vous ?"
      chips
      multiple
      v-model="foo"
      :menu-props="{ offsetY: true }"
      @change="$emit('up-search', foo)"
    ></v-autocomplete>
  </div>
</template>
<script>
import gql from "graphql-tag";
export default {
  name: "search-bar",
  data() {
    return {
      foo: []
    };
  },
  apollo: {
    tags: gql`
      query {
        tags: allTags {
          nodes {
            name
            tagId
            slug
          }
        }
      }
    `
  }
};
</script>
