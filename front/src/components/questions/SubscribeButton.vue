<template>
  <div class="subscribe-button">
    <v-btn text @click="toggleSubscribed()" style="color:white;">{{
      subscribed ? "Se désabonner" : "S'abonner"
    }}</v-btn>
  </div>
</template>

<script>
export default {
  name: "SubscribeButton",
  data() {
    return {
      subscribed: false
    };
  },
  /*
  computed: {
    subscribed() {
      // todo: graphql
    }
  },
   */
  methods: {
    toggleSubscribed(/*q*/) {
      this.subscribed = !this.subscribed;
    },
    subscribe(/*q*/) {
      this.subscribed = true;
    },
    unsubscribe(/*q*/) {
      this.subscribed = false;
    }
  }
};
</script>

<style scoped></style>
