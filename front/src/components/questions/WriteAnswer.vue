<template>
  <div>
    <v-text-field label="Votre réponse" v-model="content" required></v-text-field>
    <v-btn text @click="submitAnswer" style="color:white;">Répondre</v-btn>
  </div>
</template>

<script>
import gql from "graphql-tag";

export default {
  name: "WriteAnswer",
  data() {
    return {
      content: ""
    };
  },
  props: {
    question: String
  },
  methods: {
    submitAnswer() {
      this.$apollo
        .mutate({
          mutation: gql`
            mutation($questionId: Int!, $content: String!) {
              addAnswer(
                input: { questionId: $questionId, content: $content }
              ) {
                clientMutationId
              }
            }
          `,
          // Parameters
          variables: {
            questionId: parseInt(this.question, 10),
            content: this.content
          }
        })
        .then(() => {
          this.dialog = false;
        });
    }
  }
};
</script>

<style scoped></style>
