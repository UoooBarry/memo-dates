<template>
  <v-container>
    <v-row dense>
      <event-card v-for="event in events" :event="event" :key="event.id" @modify='editModal'/>
      <div class="plus-button">
        <v-fab-transition>
          <v-btn
            @click="openModal()"
            color="#22223b"
            dark
            absolute
            bottom
            right
            fab
          >
            <v-icon>mdi-plus</v-icon>
          </v-btn>
        </v-fab-transition>
      </div>
    </v-row>
    <EventModal :event="eventModalEvent" v-model="eventModal" @close="eventModal = false" />
  </v-container>
</template>

<script>
import EventCard from "@/components/EventCard";
import EventModal from "@/components/EventModal";
import { mapActions, mapState } from "vuex";

export default {
  name: "HomePage",
  data() {
    return {
      eventModal: false,
      eventModalEvent: {}
    };
  },
  components: {
    EventCard,
    EventModal,
  },
  computed: {
    ...mapState("events", ["loading", "events"]),
  },
  created() {
    this.fetchEvents();
  },
  methods: {
    ...mapActions("events", ["fetchEvents"]),
    openModal() {
      this.eventModalEvent = {};
      this.eventModal = true;
    },
    editModal(event) {
      this.eventModalEvent = event;
      this.eventModal = true;
    },
  },
};
</script>

<style scoped>
.plus-button {
  position: absolute;
  bottom: 10vh;
  right: 24px;
}
</style>
