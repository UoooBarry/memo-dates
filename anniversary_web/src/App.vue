<template>
  <v-app>
    <v-progress-linear indeterminate color="cyan" v-show="loading"></v-progress-linear>
    <v-main>
      <HomePage />
    </v-main>
  </v-app>
</template>

<script>
import { mapState } from 'vuex';
import HomePage from "./components/HomePage";

export default {
  name: "App",

  components: {
    HomePage,
  },
 computed: {
   ...mapState('events', ['loading'])
 },
};
</script>
