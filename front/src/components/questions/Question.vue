<template>
  <v-container v-if="question">
    <v-card class="mx-auto mb-10" outlined>
      <v-list-item three-line>
        <v-list-item-avatar tile size="80" color="grey"></v-list-item-avatar>
        <v-list-item-content>
          <div class="overline mb-4">{{ question.author.name }}</div>
          <v-list-item-title class="headline mb-1">{{
            question.title
          }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-card-text>
        {{ question.content }}
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn text>Répondre</v-btn>
      </v-card-actions>
    </v-card>
    <v-card class="mx-auto ml-10 mt-5" outlined>
      <v-list-item three-line>
        <v-list-item-avatar tile size="60" color="grey"></v-list-item-avatar>
        <v-list-item-content>
          <div class="overline mb-4">Jean-Réponse</div>
        </v-list-item-content>
      </v-list-item>
      <v-row class="pl-6">
        <v-col cols="auto">
          <v-btn icon block class="mb-8">
            <v-icon size="40">mdi-arrow-up-circle</v-icon>
          </v-btn>
          <v-btn icon block>
            <v-icon size="40">mdi-arrow-down-circle</v-icon>
          </v-btn>
        </v-col>
        <v-col cols="auto">
          <v-card-text>
            Miskine
          </v-card-text>
        </v-col>
      </v-row>
    </v-card>
  </v-container>
</template>

<script>
import gql from "graphql-tag";
export default {
  name: "Question",
  apollo: {
    allQuestions: gql`
      query {
        allQuestions {
          nodes {
            questionId
            title
            author {
              userId
              avatar
              name
            }
            postId
            content
          }
        }
      }
    `
  },
  computed: {
    question() {
      return this.allQuestions ? this.allQuestions.nodes[0] : null;
    }
  }
};
</script>

<style scoped></style>
