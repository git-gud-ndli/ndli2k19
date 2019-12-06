<template>
  <v-alert type="warning" :value="true" dismissible>
    Nouvelles données disponibles !
  </v-alert>
</template>
<script>
export default {
  name: "stale-alert"
};
</script>
