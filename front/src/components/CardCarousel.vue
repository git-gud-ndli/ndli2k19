<template>
  <div class="cont">
    <div class="text-center chip">
      <v-row justify="center" align="center">
        <v-chip class="ma-2" label color="purple" text-color="white">
          <v-icon left>mdi-pound</v-icon>
          {{ subject }}
        </v-chip>
        <v-chip class="ma-2" label color="purple" text-color="white">
          <subscribe-button
            color="purple"
            text-color="white"
          ></subscribe-button>
        </v-chip>
      </v-row>
    </div>
    <v-carousel hide-delimiters show-arrows-on-hover class="carousel-cont" v-if="showCarousel" height="1000px">
      <v-carousel-item v-for="n in getCarouselNumber(cards)" :key="n" height="100%">
        <v-sheet color="indigo lighten-5" height="100%">
          <v-container fill-height>
            <v-row style="justify-content: space-evenly;">
              <Card v-for="card in getRow(n - 1)[0]" :key="card.name" :cardData="card" />
            </v-row>
            <v-row style="justify-content: space-evenly">
              <Card v-for="card in getRow(n - 1)[1]" :key="card.name" :cardData="card" />
            </v-row>
          </v-container>
        </v-sheet>
      </v-carousel-item>
    </v-carousel>
  </div>
</template>
<script>
import Card from "../components/Card";
import SubscribeButton from "./questions/SubscribeButton";

export default {
  name: "CardCarousel",
  components: {
    SubscribeButton,
    Card
  },
  data() {
    return {
      showCarousel: true,
      windowWidth: window.innerWidth,
      slide_responsive: [
        {
          size: 200,
          itemsrow1: 1,
          itemsrow2: 0
        },
        {
          size: 640,
          itemsrow1: 2,
          itemsrow2: 2
        },
        {
          size: 1280,
          itemsrow1: 4,
          itemsrow2: 3
        }
      ],
      cards: [
        {
          type: "link",
          title: "Card1",
          data:
            "Je suis le sous-titre de la carte 1. Appuie sur visiter pour avoir plus d'infos!",
          tags: ["tag1", "tag2"],
          likes: 12
        },
        {
          type: "question",
          title: "Card2",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "doc",
          title: "Card3",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card4",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card5",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card6",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card7",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card8",
          data:
            "jbfzbfjozbeofhzbhpzkbharfjnùfzùjnfajnùfazfzùkjbkbjfzjkbhzkbhjzfkhbbkhjefzbhkeavbhkmavefvmgepzjgvbjezjbfzbfjozbeofhzbhpzkbharefzbhkeavbhkmavefvmgepzjgvbjezjbfzbfjozbeofhzbhpzkbharefzbhkeavbhkmavefvmgepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card9",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card10",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card11",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card12",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card13",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card14",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card15",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        },
        {
          type: "question",
          title: "Card16",
          data: "jbfzbfjozbeogepzjgvbjez",
          tags: ["tag1", "tag2"]
        }
      ],
      subject: "Le Bon Sujet"
    };
  },
  methods: {
    getCarouselNumber: function(cards) {
      let cardsSize = cards.length;
      let config = this.getConfig(this.windowWidth);
      let sum = config.itemsrow1 + config.itemsrow2;
      let carouselnumber = Math.ceil(cardsSize / sum);
      console.log(carouselnumber);
      return carouselnumber;
    },
    getConfig: function() {
      let i = 0;
      while (i <= 2 && this.windowWidth > this.slide_responsive[i].size) {
        i++;
      }
      return this.slide_responsive[i - 1];
    },
    getRow: function(numcar) {
      let config = this.getConfig(this.windowWidth);
      let sum = config.itemsrow1 + config.itemsrow2;
      let row1 = this.cards.slice(
        numcar * sum,
        numcar * sum + config.itemsrow1
      );
      let row2 = this.cards.slice(
        numcar * sum + config.itemsrow1,
        numcar * sum + config.itemsrow1 + config.itemsrow2
      );
      return [row1, row2];
    }
  },
  computed: {
    getScreenWidth: function() {
      return window.innerWidth;
    }
  },
  mounted() {
    window.addEventListener("resize", () => {
      this.showCarousel = false;
      this.windowWidth = window.innerWidth;
      this.$nextTick(() => {
        this.showCarousel = true;
      });
    });
  }
};
</script>
<style lang="sass">
$screen-sm-min: 200px
$screen-md-min: 640px
$screen-lg-min: 1200px

@mixin sm
   @media (min-width: #{$screen-sm-min})
       @content
@mixin md
   @media (min-width: #{$screen-md-min})
       @content
@mixin lg
   @media (min-width: #{$screen-lg-min})
       @content

.chip
  width: 300px
  @include sm
    position: absolute
    top: 10%
    left: 50%
    transform: translate(-50%, 10%)
    z-index: 1

  @include md
    position: absolute
    top: 50%
    left: 50%
    transform: translate(-50%,-50%)
    z-index: 1

  @include lg
    position: absolute
    top: 50%
    left: 50%
    transform: translate(-50%,-50%)
    z-index: 1

.cont
  position: relative
</style>
