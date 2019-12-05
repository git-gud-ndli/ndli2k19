<template>
  <v-menu
    v-model="menu"
    :close-on-content-click="false"
    :nudge-width="200"
    left
  >
    <template v-slot:activator="{ on }">
      <v-btn text v-on="on">
        <v-icon color="white">mdi-settings</v-icon>
      </v-btn>
    </template>

    <v-card>
      <v-list>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title>Paramètres</v-list-item-title>
            <!-- <v-list-item-subtitle></v-list-item-subtitle> -->
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <v-divider></v-divider>

      <v-list>
        <!-- Light / Dark Theme -->
        <v-list-item>
          <v-list-item-action>
            <v-switch class="ml-3" v-model="darkTheme"></v-switch>
          </v-list-item-action>
          <v-list-item-title>Thème Sombre</v-list-item-title>
        </v-list-item>

        <!-- Push Notifications -->
        <v-list-item v-if="navigatorPush && user">
          <v-list-item-action>
            <v-switch
              class="ml-3"
              v-model="pushState"
              :disabled="
                navigatorPush === 'denied' || navigatorPush === 'unsupported'
              "
            ></v-switch>
          </v-list-item-action>
          <v-list-item-title>Notifications Push</v-list-item-title>
        </v-list-item>

        <v-list-item v-if="navigatorPush && user">
          <v-list-item-action>
            <v-btn color="orange darken-1" :disabled="testDisabled"
              >Notification de test</v-btn
            >
          </v-list-item-action>
        </v-list-item>
      </v-list>

      <v-card-actions></v-card-actions>
    </v-card>
  </v-menu>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  name: "settings-menu",
  computed: {
    ...mapGetters({
      push: "push/push",
      user: "oidcUser"
    }),
    darkTheme: {
      get() {
        return this.$vuetify.theme.dark;
      },
      set(val) {
        this.$vuetify.theme.dark = val;
        this.$store.dispatch("setTheme", val);
      }
    },
    pushState: {
      get() {
        return this.push;
      },
      set(val) {
        this.$store.dispatch("push/setPushStatus", val);
      }
    },
    navigatorPush() {
      // check notification status in browser (and support)
      if (!("Notification" in window && "serviceWorker" in navigator)) {
        return null;
      }
      return Notification.permission;
    }
  },
  data() {
    return {
      menu: false,
      testDisabled: false
    };
  },
  methods: {}
};
</script>
