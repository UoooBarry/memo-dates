<template>
  <v-dialog v-bind="$attrs" @click:outside="$emit('close')">
    <v-card>
      <v-card-text>
        <v-text-field label="标题" v-model="title"></v-text-field>
        <v-text-field
          label="日期"
          @focus="setClickDate()"
          v-model="happen_date"
        ></v-text-field>
        <v-date-picker
          v-model="happen_date"
          v-show="clickDate"
          @input="setClickDate()"
        ></v-date-picker>
        <v-text-field label="备注" v-model="description"></v-text-field>
        <v-select
          :items="frequencyTypes"
          v-model="frequency"
          label="纪念频率"
        ></v-select>
        <v-file-input label="图片" v-model="photo"></v-file-input>

        <small class="grey--text">* 备注和图片选填.</small>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>

        <v-btn text color="primary" @click="submit"> Submit </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapActions } from "vuex";

export default {
  name: "EventModal",
  props: {
    event: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {
      id: 0,
      title: "",
      happen_date: "",
      description: "",
      photo: {},
      clickDate: false,
      frequency: "",
      frequencyTypes: [
        { text: "每年", value: "365" },
        { text: "每月", value: "30" },
        { text: "每周", value: "7" },
        { text: "每日", value: "1" },
      ],
    };
  },
  methods: {
    submit() {
      if (this.event.id) {
        this.patchEvent();
      } else {
        this.newEvent();
      }
      this.$emit("close");
    },
    ...mapActions("events", ["createEvent", "updateEvent"]),
    setClickDate() {
      this.clickDate = !this.clickDate;
    },
    newEvent() {
      const bodyFormData = new FormData();
      bodyFormData.append("photo", this.photo);
      bodyFormData.append("title", this.title);
      bodyFormData.append("happen_date", this.happen_date);
      bodyFormData.append("description", this.description);
      bodyFormData.append("frequency", this.frequency);
      this.createEvent(bodyFormData);
    },
    patchEvent() {
      const bodyFormData = new FormData();
      bodyFormData.append("photo", this.photo);
      bodyFormData.append("title", this.title);
      bodyFormData.append("happen_date", this.happen_date);
      bodyFormData.append("description", this.description);
      bodyFormData.append("frequency", this.frequency);
      this.updateEvent({ id: this.id, event: bodyFormData });
    },
  },
  watch: {
    event: function (val) {
      if (val) {
        this.id = val.id;
        this.title = val.title;
        this.happen_date = val.happen_date;
        this.description = val.description;
        this.photo = val.photo;
        this.frequency = val.frequency;
      }
    },
  },
};
</script>
