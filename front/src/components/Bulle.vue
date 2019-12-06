<template>
  <v-card
    style="height:100%;width:100%;border-radius:100%"
    class="d-inline-block mx-auto bulle"
    @click="toggleActive()"
    v-bind:class="{ active: active }"
  >
    <v-container fill-height text-center grid-list-md text-xs-center>
      <v-layout row wrap align-center>
        <v-flex>
          <div class="headline">#{{ title }}</div>
        </v-flex>
      </v-layout>
    </v-container>
  </v-card>
</template>

<script>
export default {
  props: ["title"],
  data() {
    return {
      active: false
    };
  },
  methods: {
    toggleActive() {
      this.active = !this.active;
      this.$emit("toggle-active", this.active);
    },
    getSize() {
      return this.size ? this.size : 100;
    }
  },
  name: "Bulle"
};
</script>

<style scoped>
.v-card--link:before {
  background:transparent;
}</style>
