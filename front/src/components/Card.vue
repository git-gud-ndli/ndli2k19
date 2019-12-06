<template>
  <div>
    <v-hover v-slot:default="{ hover }">
      <v-card height="300px" width="300px" :color="getColor()" :elevation="hover ? 12 : 2">
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
              >{{ chip }}</v-chip>
            </div>
            <v-list-item-title class="headline mb-1">
              {{
              cardData.title
              }}
            </v-list-item-title>
            <v-list-item-subtitle class="contenu">{{ cardData.data }}</v-list-item-subtitle>
          </v-list-item-content>

          <v-list-item-avatar tile size="30">
            <v-icon>{{ getIcon() }}</v-icon>
          </v-list-item-avatar>
        </v-list-item>

        <v-card-actions class="actions">
          <v-btn small outlined rounded color="white accent-4" style="margin-left: 5px">Plus</v-btn>
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
      let color = "";
      switch (this.cardData.type) {
        case "link":
          color = "green";
          break;
        case "doc":
          color = "orange";
          break;
        case "question":
          color = "red";
          break;
        default:
          color = "grey";
          break;
      }
      return color;
    },
    getIcon() {
      let icon = "";
      switch (this.cardData.type) {
        case "link":
          icon = "mdi-heart";
          break;
        case "doc":
          icon = "mdi-file-document";
          break;
        case "question":
          icon = "mdi-help";
          break;
        default:
          icon = "mdi-error";
          break;
      }
      return icon;
    }
  },
  props: {
    cardData: Object
  }
};
</script>
<style scoped>
.contenu {
  min-height: 125px;
}
</style>