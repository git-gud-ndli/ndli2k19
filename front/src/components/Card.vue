<template>
  <div>
    <v-hover v-slot:default="{ hover }">
      <v-card
        width="300px"
        v-if="cardData.type == 'question'"
        color="red"
        :elevation="hover ? 12 : 2"
      >
        <v-card-title>
          <v-icon large left>mdi-help</v-icon>
          <span class="title font-weight-light">{{ cardData.title }}</span>
        </v-card-title>
        <v-card-text>{{ cardData.data }}</v-card-text>
        <v-btn text color="white accent-4">Plus</v-btn>
        <v-chip
          v-for="chip in cardData.tags"
          :key="chip.tag"
          class="ma-2"
          color="purple"
          text-color="white"
          >{{ chip }}</v-chip
        >
      </v-card>
    </v-hover>
    <v-hover v-slot:default="{ hover }">
      <v-card
        width="300px"
        v-if="cardData.type == 'doc'"
        color="blue"
        :elevation="hover ? 12 : 2"
      >
        <v-card-title>
          <v-icon large left>mdi-file-document</v-icon>
          <span class="title font-weight-light">{{ cardData.title }}</span>
        </v-card-title>
        <v-card-text>{{ cardData.data }}</v-card-text>
        <v-btn text color="white accent-4">Télécharger</v-btn>
        <v-chip
          v-for="chip in cardData.tags"
          :key="chip.tag"
          class="ma-2"
          color="purple"
          text-color="white"
          >{{ chip }}</v-chip
        >
      </v-card>
    </v-hover>
    <v-hover v-slot:default="{ hover }">
      <v-card
        width="300px"
        v-if="cardData.type == 'link'"
        color="green"
        :elevation="hover ? 12 : 2"
      >
        <v-card-title>
          <v-icon large left>mdi-link-variant</v-icon>
          <span class="title font-weight-light">{{ cardData.title }}</span>
        </v-card-title>
        <v-card-text>{{ cardData.data }}</v-card-text>
        <v-btn text justify-center color="white accent-4">Visiter</v-btn>
        <v-chip
          v-for="chip in cardData.tags"
          :key="chip.tag"
          class="ma-2"
          color="purple"
          text-color="white"
          >{{ chip }}</v-chip
        >
      </v-card>
    </v-hover>
  </div>
</template>
<script>
export default {
  name: "Card",
  props: {
    cardData: Object
  }
};
</script>
