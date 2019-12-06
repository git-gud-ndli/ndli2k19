<template>
  <v-footer padless>
    <v-card class="flex" flat tile>
      <v-card-title class="blue lighten-3">
        <strong class="white--text"
          >Suivez-nous sur les réseaux sociaux!</strong
        >

        <v-spacer></v-spacer>

        <v-btn
          v-for="s in social"
          :key="s.icon"
          class="mx-4"
          dark
          icon
          :href="s.link"
        >
          <v-icon size="24px">{{ s.icon }}</v-icon>
        </v-btn>
      </v-card-title>

      <v-card-text class="py-2 white--text text-center blue lighten-2">
        {{ new Date().getFullYear() }} — <strong>Git-gud(1)</strong>
      </v-card-text>
    </v-card>
  </v-footer>
</template>
<script>
export default {
  name: "Footer",
  data: () => ({
    social: [
      {
        icon: "mdi-facebook",
        link: "https://www.facebook.com/"
      },
      {
        icon: "mdi-twitter",
        link: "https://twitter.com/nuitinfo"
      },
      {
        icon: "mdi-instagram",
        link: "https://www.instagram.com/"
      }
    ]
  })
};
</script>
