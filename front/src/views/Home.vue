<template>
  <div>
    <Banner :slides="slides"></Banner>
    <question-form></question-form>
    <TagSearchContainer :tagsAppliques="tagsAppliques" />
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
import QuestionForm from "../components/QuestionForm";
import TagSearchContainer from "../components/TagSearchContainer";

export default {
  data() {
    return {
      tagsAppliques: [],
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
    QuestionForm,
    Banner,
    CardCarousel,
    Footer,
    TagSearchContainer
  },
  methods: {
    foo() {
      this.$store.dispatch("setStale", true);
    }
  }
};
</script>
