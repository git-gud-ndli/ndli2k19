<template>
  <div>
    <v-autocomplete
      :items="items"
      label="Que cherchez-vous ?"
      chips
      multiple
      :menu-props="{ offsetY: true }"
    ></v-autocomplete>
  </div>
</template>
<script>
export default {
  name: "search-bar",
  computed: {
    items() {
      return ["Moulaga", "Jean", "Bar", "Issou"];
    }
  }
};
</script>
