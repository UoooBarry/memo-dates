<template>
  <v-col cols="12">
    <v-card elevation="2" :color="getRandomColor()" dark>
      <div class="d-flex flex-no-wrap justify-space-between">
        <div>
          <v-card-title class="text-h5">
            {{ event.title }}
          </v-card-title>
          <v-card-subtitle text>{{ event.happen_date }}</v-card-subtitle>
          <v-card-text>
            <div>{{ event.description }}</div>
          </v-card-text>
          <v-card-actions>
            <v-btn text @click='modify()'> Modify </v-btn>
            <v-btn text @click='remove()'> <v-icon>mdi-trash-can</v-icon> </v-btn>
          </v-card-actions>
        </div>
        <v-avatar class="ma-3" size="125" tile>
          <v-img v-if="event.photo.url" :src="getFullFile(event.photo.url)"></v-img>
          <v-img v-else src="@/assets/christmas.png"></v-img>
        </v-avatar>
      </div>
    </v-card>
  </v-col>
</template>

<script>
import { getFullFile } from "@/api/events";
import { mapActions } from 'vuex';

export default {
  name: "EventCard",
  props: {
    event: {
      type: Object,
      required: true,
    },
  },
  methods: {
    getRandomColor() {
      const colors = ["#005f73", "#22223b", "#4a4e69", "#9a8c98"];
      return colors[Math.floor(Math.random() * colors.length)];
    },
    modify() {
      this.$emit("modify", this.event);
    },
    remove() {
      this.deleteEvent(this.event.id);
    },
    ...mapActions('events', ['deleteEvent']),
  },
  data() {
    return {
      getFullFile,
    };
  },
};
</script>
