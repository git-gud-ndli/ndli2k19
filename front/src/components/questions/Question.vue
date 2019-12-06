<template>
  <v-container v-if="question">
    <v-card class="mx-auto mb-10" outlined>
      <v-list-item three-line>
        <v-list-item-avatar tile size="80" color="grey"></v-list-item-avatar>
        <v-list-item-content>
          <div class="overline mb-4">{{ question.author ? question.author.name : "Anonymous" }}</div>
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

    <v-card>
      <write-answer :question="question.questionId"></write-answer>
    </v-card>

    <v-card
      class="mx-auto ml-10 mt-5"
      v-bind:key="answer"
      v-for="answer in answers.nodes"
      outlined
    >
      <v-list-item three-line>
        <v-list-item-avatar tile size="60" color="grey"></v-list-item-avatar>
        <v-list-item-content>
          <div class="overline mb-4">
            {{ answer.author ? answer.author.name : "Anonymous" }}
          </div>
        </v-list-item-content>
      </v-list-item>
      <v-row class="pl-6">
        <v-col cols="auto">
          <UpDown
            v-on:up="upvote(answer.postId)"
            v-on:down="downvote(answer.postId)"
            v-bind:up="answer.votes ? answer.votes.upvotes : 0"
            v-bind:down="answer.votes ? answer.votes.downvotes : 0"
            width="50px"
          ></UpDown>
        </v-col>
        <v-col cols="auto">
          <v-card-text>
            {{ answer.content }}
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
import WriteAnswer from "./WriteAnswer";

export default {
  name: "Question",
  apollo: {
    question: {
      query: gql`
        query GetQuestion($qid: Int!) {
          question: questionByQuestionId(questionId: $qid) {
            title
            content
            questionId
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
    },
    tags: gql`
      query {
        tags: allTags {
          nodes {
            name
            tagId
            slug
          }
        }
      }
    `,
    answers: {
      query: gql`
        query GetAnswers($qid: Int!) {
          answers: allAnswers(condition: { questionId: $qid }) {
            nodes {
              userId
              content
              postId
              votes {
                downvotes
                upvotes
                postId
              }
              author {
                name
              }
            }
            totalCount
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
    WriteAnswer,
    UpDown,
    SubscribeButton
  },
  methods: {
    downvote(postId) {
      this.$apollo.mutate({
        mutation: gql`
          mutation($postId: Int!) {
            addDownvote(input: { postId: $postId }) {
              clientMutationId
            }
          }
        `,
        // Parameters
        variables: {
          postId: postId
        }
      });
    },
    upvote(postId) {
      this.$apollo.mutate({
        mutation: gql`
          mutation($postId: Int!) {
            addUpvote(input: { postId: $postId }) {
              clientMutationId
            }
          }
        `,
        // Parameters
        variables: {
          postId: postId
        }
      });
    }
  }
};
</script>

<style scoped></style>
