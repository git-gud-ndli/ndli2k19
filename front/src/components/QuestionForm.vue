<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" max-width="600px">
      <template v-slot:activator="{ on }">
        <v-btn color="primary" dark v-on="on" @click.stop="dialog = true">
          Posez votre question
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">Posez votre question</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  label="Titre*"
                  required
                  v-model="title"
                ></v-text-field>
              </v-col>

              <v-col cols="12">
                <v-text-field
                  label="Question"
                  required
                  v-model="content"
                ></v-text-field>
              </v-col>

              <v-col cols="12" sm="6">
                <v-autocomplete
                  v-if="tags"
                  :items="tags.nodes"
                  item-text="name"
                  item-value="tagId"
                  label="Etiquettes"
                  multiple
                ></v-autocomplete>
              </v-col>
            </v-row>
          </v-container>
          <small>*indique un champ requis</small>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false"
            >Close</v-btn
          >
          <v-btn color="blue darken-1" text @click="submitQuestion">Save</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import gql from "graphql-tag";
export default {
  name: "QuestionForm",
  data: () => {
    return {
      dialog: false,
      title: "",
      content: ""
    };
  },
  apollo: {
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
    `
  },
  methods: {
    submitQuestion() {
      this.$apollo
        .mutate({
          mutation: gql`
            mutation($title: String!, $content: String!) {
              addQuestion(input: { title: $title, content: $content }) {
                question {
                  questionId
                  title
                }
              }
            }
          `,
          // Parameters
          variables: {
            title: this.title,
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
