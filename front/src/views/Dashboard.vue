<template>
  <v-container grid-list-md>
    <v-layout row wrap>
      <v-flex xs12 sm4 v-for="t of tiles" :key="t.name">
        <v-hover>
          <v-card
            slot-scope="{ hover }"
            :class="`elevation-${hover ? 12 : 2}`"
            min-height="350px"
          >
            <v-card-title primary-title class="justify-center display-2">{{
              t.name
            }}</v-card-title>
            <v-card-text class="text-center">
              <v-icon size="96">{{ t.icon }}</v-icon>
            </v-card-text>
          </v-card>
        </v-hover>
      </v-flex>
    </v-layout>
  </v-container>
</template>
<script>
export default {
  name: "dashboard",
  computed: {
    tiles() {
      return [
        { name: "Profile", icon: "mdi-account", url: "home" },
        { name: "La bonne action", icon: "mdi-billiards-rack", url: "home" },
        { name: "FlipFlop", icon: "mdi-diving-flippers", url: "home" },
        { name: "ZioumBoumBoum", icon: "mdi-equalizer", url: "home" }
      ];
    }
  }
};
</script>
<style lang="sass" scoped></style>
