<template>
  <v-card
    style="height:100%;width:100%;border-radius:100%"
    class="d-inline-block mx-auto bulle"
    @click="setActive(!active)"
    v-bind:class="{ active: active }"
  >
    <v-container fill-height text-center grid-list-md text-xs-center>
      <v-layout row wrap align-center>
        <v-flex>
          <h3>{{ title }}</h3>
        </v-flex>
      </v-layout>
    </v-container>
  </v-card>
</template>

<script>
export default {
  props: ["title", "size"],
  data() {
    return {
      active: false
    };
  },
  methods: {
    setActive(active) {
      this.$emit("toggle-active", active);
    },
    getSize() {
      return this.size ? this.size : 100;
    }
  },
  name: "Bulle"
};
</script>

<style scoped></style>
