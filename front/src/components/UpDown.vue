<template>
  <div
    class="thumbs"
    v-bind:class="{ customClass }"
    v-bind:style="{ width: width }"
  >
    <v-icon class="up" :size="width" @click="doUp">mdi-thumb-up</v-icon>
    <div class="title text-center" v-bind:style="{ color: getColor() }">
      {{ up - down }}
    </div>
    <v-icon class="down" :size="width" @click="doDown">mdi-thumb-down</v-icon>
  </div>
</template>

<script>
export default {
  props: {
    up: {
      type: Number,
      default: 0
    },
    down: {
      type: Number,
      default: 0
    },
    customClass: String,
    width: {
      type: String,
      default: "50px"
    }
  },
  data() {
    return {};
  },
  methods: {
    doUp() {
      this.$emit("up");
    },
    doDown() {
      this.$emit("down");
    },
    getColor() {
      return this.up - this.down > 0
        ? "#4CAF50"
        : this.up - this.down == 0
        ? ""
        : "#F44336";
    }
  },
  name: "UpDown"
};
</script>

<style scoped>
.up:hover {
  color: #4caf50;
}
.down:hover {
  color: #f44336;
}
</style>
