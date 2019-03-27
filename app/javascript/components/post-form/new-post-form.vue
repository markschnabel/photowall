<template>
  <div class="wrapper">
    <message
      :show-new-post-success-msg="this.success"
      :post-id="this.newPostId"
      :posts-base-url="this.postsBaseUrl"
      :show-unknown-error-msg="this.unknownError"
      v-on:closeMessage="closeMessage()"
    />
    <h1>Create a new post</h1>
    <form
      v-bind:class="loading ? 'ui form loading' : 'ui form'"
      @submit="(e) => sendDataToServer(e)"
    >
      <form-field
        label="Title"
        field-name="title"
        :value="this.title"
        v-on:updateField="title = $event"
        placeholder="ex: A Big, Giant and Huge Photo"
        helper-message="Give your post a title (required). Must be between 4-20 characters."
        :error-message="this.errors.title"
        isRequired
      />
      <image-dropzone
        :image="this.image"
        :filename="this.filename"
        :error-message="this.errors.image"
        v-on:changeImage="updateImage($event)"
        v-on:changeImageError="updateImageError($event)"
      />
      <form-field
        label="Name"
        field-name="postedBy"
        :value="this.postedBy"
        v-on:updateField="postedBy = $event"
        placeholder="ex: Abraham Lincoln"
        helper-message='Your real name or a screen name. Must be left blank or be between 4-30 characters. Defaults to "anonymous"'
        :error-message="this.errors.posted_by"
      />
      <form-field
        useTextarea
        label="Caption"
        field-name="caption"
        :value="this.caption"
        v-on:updateField="caption = $event"
        placeholder="ex: This photo is so big. So big, you really don't even get it."
        helper-message='Describe your photo. Must be left blank or be between 4-280 characters. Defaults to "(no caption)"'
        :error-message="this.errors.caption"
      />
      <button class="ui submit button" type="submit">Submit</button>
    </form>
  </div>
</template>

<script>
import FormField from "./form-field";
import ImageDropzone from "./image-dropzone";
import Message from "./message";

export default {
  props: {
    postsBaseUrl: {
      type: String,
      required: true,
    },
  },
  components: {
    "form-field": FormField,
    "image-dropzone": ImageDropzone,
    "message": Message
  },
  data() {
    return {
      title: "",
      postedBy: "",
      caption: "",
      image: null,
      filename: null,

      loading: false,

      success: false,
      newPostId: null,
      errors: {},
      unknownError: false
    };
  },
  methods: {
    updateImage(image) {
      const fileReader = new FileReader();

      fileReader.addEventListener("load", () => {
        this.image = fileReader.result;
      });

      this.filename = image.name;
      this.errors.image = null;
      fileReader.readAsDataURL(image);
    },
    updateImageError(errorMessage) {
      this.$set(this.errors, "image", errorMessage);
      this.image = null;
    },
    sendDataToServer(e) {
      e.preventDefault();

      this.loading = true;

      const post = {
        title: this.title,
        image: this.image,
        posted_by: this.postedBy,
        caption: this.caption
      };

      this.$http
        .post("/posts.json", post)
        .then(res => this.handleSuccess(res.data.id))
        .catch(err => this.handleError(err))
        .finally(() => (this.loading = false));
    },
    handleSuccess(newPostId) {
      this.success = true;
      this.newPostId = newPostId;
      this.filename = null;
      this.image = null;
      this.title = null;
      this.postedBy = null;
      this.caption = null;
      this.loading = false;
      this.errors = {};
    },
    handleError(err) {
      // refresh errors
      this.errors = {};

      // load in new errors
      if (err.response && err.response.data) {
        for (let [fieldName, errorMessages] of Object.entries(
          err.response.data
        )) {
          this.errors[fieldName] = errorMessages[errorMessages.length - 1];
        }
      } else {
        this.unknownError = true;
      }
    },
    closeMessage() {
      this.success = false;
      this.unknownError = false;
    }
  }
};
</script>

<style scoped>
.wrapper {
  margin: auto;
  max-width: 800px;
  padding: 0 10px;
}
</style>

<style>
.helper-text {
  padding-top: 2.5px;
  font-size: 0.85em;
  color: #999;
  font-style: italic;
  margin-left: 5px;
}
.helper-text-error {
  color: rgb(189, 2, 2) !important;
}
</style>
