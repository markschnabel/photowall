<template>
  <div class="ui grid centered stackable">
    <div class="section-wrapper six wide column">
      <message
        :show-update-success-msg="this.success"
        :post-id="this.post.id"
        :posts-base-url="this.postsBaseUrl"
        :show-unknown-error-msg="this.unknownError"
        v-on:closeMessage="closeMessage()"
      />
      <h1 class="page-header">Edit a post</h1>
      <p class="helper-text">Note: Images cannot be changed once they have been uploaded</p>
      <br>
      <form
        v-bind:class="loading ? 'ui form loading' : 'ui form'"
        @submit="(e) => sendDataToServer(e)"
      >
        <form-field
          label="Title"
          field-name="title"
          :value="this.post.title"
          v-on:updateField="updateField($event, 20, 'title')"
          placeholder="ex: A Big, Giant and Huge Photo"
          helper-message="Edit the title of your post. This is a required field. Must be between 4-20 characters."
          :error-message="this.errors.title"
          isRequired
        />
        <form-field
          label="Name"
          field-name="postedBy"
          :value="this.post.posted_by"
          v-on:updateField="updateField($event, 30, 'posted_by')"
          placeholder="ex: Abraham Lincoln"
          helper-message="Your real name or a screen name. Must be left blank or be between 4-30 characters. Defaults to 'anonymous'"
          :error-message="this.errors.posted_by"
        />
        <form-field
          useTextarea
          label="Caption"
          field-name="caption"
          :value="this.post.caption"
          v-on:updateField="updateField($event, 280, 'caption')"
          placeholder="ex: This photo is so big. So big, you really don't even get it."
          helper-message="Describe your photo. Must be left blank or be between 4-280 characters. Defaults to '(no caption)'"
          :error-message="this.errors.caption"
        />
        <button class="ui submit button" type="submit">Submit</button>
      </form>
    </div>
    <div class="section-wrapper six wide column">
      <h1>Preview:</h1>
      <single-post :post="this.post" :show-options-menu="false"/>
    </div>
  </div>
</template>

<script>
import FormField from "./form-field";
import Message from "./message";
import SinglePost from "../posts/single-post";

export default {
  props: {
    postData: { type: Object, required: true },
    postsBaseUrl: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      post: this.postData,
      filename: null,
      loading: false,
      success: false,
      errors: {},
      unknownError: false
    };
  },
  components: {
    "form-field": FormField,
    message: Message,
    "single-post": SinglePost
  },
  methods: {
    updateField(event, maxLength, fieldName) {
      if (event.length > maxLength) {
        this.$set(
          this.errors,
          fieldName,
          `must not execeed ${maxLength} characters.`
        );
        return;
      }
      if (fieldName === "title" && event.length === 0) {
        this.$set(this.errors, fieldName, "cannot be blank");
        this.$set(this.post, fieldName, event);
      } else {
        this.$set(this.errors, fieldName, null);
        this.$set(this.post, fieldName, event);
      }
    },
    handleSuccess() {
      this.success = true;
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
    sendDataToServer(e) {
      e.preventDefault();

      this.loading = true;

      this.$http
        .put(`/posts/${this.post.id}.json`, {
          title: this.post.title,
          posted_by: this.post.posted_by,
          caption: this.post.caption
        })
        .then(_res => this.handleSuccess(this.post.id))
        .catch(err => this.handleError(err))
        .finally(() => (this.loading = false));
    }
  },
  closeMessage() {
    this.success = false;
    this.unknownError = false;
  }
};
</script>

<style>
.form-wrapper {
  margin: auto !important;
}
.section-wrapper {
  max-width: 800px;
  padding: 0 10px;
}
.page-header {
  margin-bottom: 0;
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
