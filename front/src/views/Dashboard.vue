<template>
  <v-container grid-list-md>
    <v-layout row wrap>
      <v-flex xs12>
        <question-form></question-form>
      </v-flex>
    </v-layout>

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
import QuestionForm from "../components/QuestionForm";
export default {
  name: "dashboard",
  components: { QuestionForm },
  computed: {
    tiles() {
      return [];
    }
  }
};
</script>

<style lang="sass" scoped>
question-form
  margin-bottom: 10px
</style>
