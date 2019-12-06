<template>
  <div>
    <Banner :slides="slides"></Banner>
    <CardCarousel />
    <v-divider dark></v-divider>
    <CardCarousel />
    <Footer />
  </div>
</template>

<script>
import Banner from "../components/Banner";
import CardCarousel from "../components/CardCarousel";
import Footer from "../components/Footer";

export default {
  data() {
    return {
      slides: [
        {
          src:
            "https://images.pexels.com/photos/1438072/pexels-photo-1438072.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
          txt: "Une plateforme #collaborative#"
        },
        {
          src:
            "https://images.pexels.com/photos/261909/pexels-photo-261909.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
          txt: "Des #tags# du moment"
        },
        {
          src:
            "https://images.pexels.com/photos/261895/pexels-photo-261895.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
          txt: "#hey# wassup"
        }
      ]
    };
  },
  name: "home",
  components: {
    Banner,
    CardCarousel,
    Footer
  },
  methods: {
    foo() {
      this.$store.dispatch("setStale", true);
    }
  }
};
</script>
