<template>
  <div>
    <div v-if="this.showSuccessMsg && this.newPostId" class="ui success message">
      <i class="close icon" @click="closeMessage"></i>
      <div class="header">Congratulations!</div>
      <p>
        Your post was successfully uploaded.
        <a
          v-bind:href="`${postsBaseUrl}/${this.newPostId}`"
          class="post-link"
        >Click here</a>
        to view it or create another down below.
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
    showSuccessMsg: { type: Boolean },
    newPostId: { type: Number },
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