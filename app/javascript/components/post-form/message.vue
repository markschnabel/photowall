<template>
  <div>
    <div v-if="this.showNewPostSuccessMsg && this.postId" class="ui success message">
      <i class="close icon" @click="closeMessage"></i>
      <div class="header">Congratulations!</div>
      <p>
        Your post was successfully created!
        <a
          v-bind:href="`${postsBaseUrl}/${this.postId}`"
          class="post-link"
        >Click here</a>
        to view it or create another down below.
      </p>
    </div>
    <div v-else-if="this.showUpdateSuccessMsg && this.postId" class="ui success message">
      <i class="close icon" @click="closeMessage"></i>
      <div class="header">Congratulations!</div>
      <p>
        Your post was successfully updated!
        <a
          v-bind:href="`${postsBaseUrl}/${this.postId}`"
          class="post-link"
        >Click here</a>
        to view it or continue modifying it down below.
      </p>
    </div>
    <div v-else-if="this.showUnknownErrorMsg" class="ui error message">
      <i class="close icon" @click="closeMessage"></i>
      <div class="header">An unknown error has occured!</div>
      <p>We're sorry about this. Please try again shortly.</p>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    showNewPostSuccessMsg: { type: Boolean },
    showUpdateSuccessMsg: { type: Boolean },
    postId: { type: Number },
    showUnknownErrorMsg: { type: Boolean },
    postsBaseUrl: {
      type: String,
      required: true
    }
  },
  methods: {
    closeMessage() {
      this.$emit("closeMessage");
    }
  }
};
</script>