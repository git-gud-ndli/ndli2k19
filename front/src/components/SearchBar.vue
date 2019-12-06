<template>
    <v-autocomplete
      :items="items"
      label="Que cherchez-vous ?"
      chips
      multiple
      :menu-props="{ offsetY: true }"
    ></v-autocomplete>
</template>
<script>
export default {
  name: "search-bar",
  props: {
    items: Array
  }
};
</script>
