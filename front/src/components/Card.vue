<template>
  <div>
    <v-hover v-slot:default="{ hover }">
      <v-card
        height="300px"
        width="300px"
        v-if="cardData.type == 'question'"
        :color="getColor()"
        :elevation="hover ? 12 : 2"
      >
        <v-list-item three-line>
          <v-list-item-content>
            <div class="overline mb-4">
              <v-chip
                v-for="chip in cardData.tags"
                :key="chip.tag"
                class="ma-2"
                color="purple"
                text-color="white"
                small
                >{{ chip }}</v-chip
              >
            </div>
            <v-list-item-title class="headline mb-1">{{
              cardData.title
            }}</v-list-item-title>
            <v-list-item-subtitle>
              {{ cardData.data }}
            </v-list-item-subtitle>
          </v-list-item-content>

          <v-list-item-avatar tile size="30">
            <v-icon>mdi-help</v-icon>
          </v-list-item-avatar>
        </v-list-item>

        <v-card-actions>
          <v-btn small outlined rounded color="white accent-4">Plus</v-btn>
          <v-spacer></v-spacer>
          <v-btn icon>
            <v-icon>mdi-heart</v-icon>
          </v-btn>
          <span class="subheading mr-2">{{ cardData.likes }}</span>
        </v-card-actions>
      </v-card>
    </v-hover>
    <v-hover v-slot:default="{ hover }">
      <v-card
        height="300px"
        width="300px"
        v-if="cardData.type == 'doc'"
        color="blue lighten-1"
        :elevation="hover ? 12 : 2"
      >
        <v-list-item three-line>
          <v-list-item-content>
            <div class="overline mb-4">
              <v-chip
                v-for="chip in cardData.tags"
                :key="chip.tag"
                class="ma-2"
                color="purple"
                text-color="white"
                small
                >{{ chip }}</v-chip
              >
            </div>
            <v-list-item-title class="headline mb-1">{{
              cardData.title
            }}</v-list-item-title>
            <v-list-item-subtitle>
              {{ cardData.data }}
            </v-list-item-subtitle>
          </v-list-item-content>

          <v-list-item-avatar tile size="30">
            <v-icon>mdi-file-document</v-icon>
          </v-list-item-avatar>
        </v-list-item>

        <v-card-actions>
          <v-btn small outlined rounded color="white accent-4"
            >Télécharger</v-btn
          >
          <v-spacer></v-spacer>
          <v-btn icon>
            <v-icon>mdi-heart</v-icon>
          </v-btn>
          <span class="subheading mr-2">{{ cardData.likes }}</span>
        </v-card-actions>
      </v-card>
    </v-hover>
    <v-hover v-slot:default="{ hover }">
      <v-card
        height="300px"
        width="300px"
        v-if="cardData.type == 'link'"
        color="green lighten-1"
        :elevation="hover ? 12 : 2"
      >
        <v-list-item three-line>
          <v-list-item-content>
            <div class="overline mb-4">
              <v-chip
                v-for="chip in cardData.tags"
                :key="chip.tag"
                class="ma-2"
                color="purple"
                text-color="white"
                small
                >{{ chip }}</v-chip
              >
            </div>
            <v-list-item-title class="headline mb-1">{{
              cardData.title
            }}</v-list-item-title>
            <v-list-item-subtitle>
              {{ cardData.data }}
            </v-list-item-subtitle>
          </v-list-item-content>

          <v-list-item-avatar tile size="30">
            <v-icon>mdi-link-variant</v-icon>
          </v-list-item-avatar>
        </v-list-item>

        <v-card-actions>
          <v-btn small outlined rounded color="white accent-4">Visiter</v-btn>
          <v-spacer></v-spacer>
          <v-btn icon>
            <v-icon>mdi-heart</v-icon>
          </v-btn>
          <span class="subheading mr-2">{{ cardData.likes }}</span>
        </v-card-actions>
      </v-card>
    </v-hover>
  </div>
</template>
<script>
export default {
  name: "Card",
  methods: {
    getColor() {
      switch (cardData.type) {
        case value:
          
          break;
      
        default:
          break;
      }
    }
  }
  props: {
    cardData: Object
  }
};
</script>
