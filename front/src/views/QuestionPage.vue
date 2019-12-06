<template>
  <question></question>
</template>

<script>
import Question from "../components/questions/Question";

export default {
  name: "QuestionPage",
  components: {
    Question
  },
  data: () => ({
    length: 3,
    window: 0,
  })
}
</script>

<style scoped>
</style>
