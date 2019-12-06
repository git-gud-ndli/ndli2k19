<template>
  <div style="position: relative;">
    <v-carousel
      cycle
      height="100vh"
      hide-delimiter-background
      show-arrows-on-hover
      hide-delimiters
    >
      <v-carousel-item v-for="(slide, i) in slides" :key="i" :src="slide.src">
        <v-sheet height="100%" color="transparent">
          <v-row
            class="fill-height slide-header"
            align="center"
            justify="center"
          >
            <div class="display-2 font-weight-light text-uppercase">
              {{ slide.txt.split("#")[0] }}
            </div>
            <div class="display-4 font-weight-black text-uppercase">
              {{ slide.txt.split("#")[1] }}
            </div>
            <div class="display-2 font-weight-light text-uppercase">
              {{ slide.txt.split("#")[2] }}
            </div>
          </v-row>
        </v-sheet>
      </v-carousel-item>
    </v-carousel>
    <div class="go-down">
      <v-icon size="70px">mdi-pan-down</v-icon>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    height: Number,
    slides: Object
  },
  data() {
    return {};
  },
  methods: {},
  name: "Banner"
};
</script>

<style scoped>
.go-down {
  position: absolute;
  bottom: 0;
  left: 50%;
  animation: up-down 1s infinite alternate;
}
.go-down i {
  color: white;
}
.slide-header > div {
  color: yellow;
}
@keyframes up-down {
  0% {
    transform: translate(-50%, 0);
  }
  100% {
    transform: translate(-50%, -20px);
  }
}
</style>
