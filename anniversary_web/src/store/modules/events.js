import { getEvents, createEvent, updateEvent, deleteEvent } from "../../api/events";

const eventModule = {
  namespaced: true,
  state: {
    events: [],
    loading: false,
  },
  mutations: {
    setEvent(state, events) {
      state.events = events;
    },
    setLoading(state, loading) {
      state.loading = loading;
    },
    pushEvent(state, event) {
      state.events.push(event);
    },
    updateEvent(state, event) {
      state.events = state.events.map((item) => {
        if (item.id === event.id) {
          return event;
        }
        return item;
      });
    },
    deleteEvent(state, eventId) {
      state.events = state.events.filter((event) => event.id !== eventId);
    }
  },
  getters: {
    loading: (state) => {
      return state.loading;
    },
    events: (state) => {
      return state.events;
    },
  },
  actions: {
    fetchEvents({ commit }) {
      commit("setLoading", true);
      getEvents().then((events) => {
        commit("setEvent", events);
      });
      commit("setLoading", false);
    },
    createEvent({ commit }, event) {
      commit("setLoading", true);
      createEvent(event).then((event) => {
        commit("pushEvent", event);
      });
      commit("setLoading", false);
    },
    updateEvent({ commit }, { id, event }) {
      commit("setLoading", true);
      updateEvent(id, event).then((event) => {
        commit("updateEvent", event);
      });
      commit("setLoading", false);
    },
    deleteEvent({ commit }, id) {
      commit("setLoading", true);
      deleteEvent(id).then(() => {
        commit("deleteEvent", id);
      });
      commit("setLoading", false);
    }
  },
};

export default eventModule;
