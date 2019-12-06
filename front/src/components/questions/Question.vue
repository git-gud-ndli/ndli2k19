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

      <v-row justify="end">
        <v-col md="auto">
          <v-card-actions>
            <subscribe-button></subscribe-button>
          </v-card-actions>
        </v-col>
        <v-col md="auto">
          <v-card-actions>
            <v-btn text>Répondre</v-btn>
          </v-card-actions>
        </v-col>
      </v-row>
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
          <UpDown v-on:up="upvote" v-on:down="downvote" width="50px"></UpDown>
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
import SubscribeButton from "./SubscribeButton";
import UpDown from "../UpDown";
import gql from "graphql-tag";

export default {
  name: "Question",
  apollo: {
    question: {
      query: gql`
        query GetQuestion($qid: Int!) {
          question: questionByQuestionId(questionId: $qid) {
            title
            content
            author {
              name
            }
          }
        }
      `,
      variables() {
        return {
          qid: parseInt(this.$route.params.slug, 10)
        };
      }
    }
  },
  components: {
    UpDown,
    SubscribeButton
  },
  computed: {},
  methods: {
    upvote() {
      //
    },
    downvote() {
      //
    },
  }
};
</script>

<style scoped></style>
