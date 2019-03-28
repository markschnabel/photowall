<template>
  <div v-if="this.loading" class="loading">
    <i class="spinner icon large spin-animation"></i>
    <p class="loading-text">Loading</p>
  </div>
  <div v-else-if="this.deleted">
    <div class="ui message success deleted">
      <div class="header">Success!</div>This post has been successfully deleted
    </div>
  </div>
  <div v-else class="ui card post">
    <div class="title-area">
      <a v-if="!showPage" v-bind:href="`${postsBaseUrl}/${post.id}`">
        <h3 class="title">{{ post.title }}</h3>
      </a>
      <h3 v-else class="title">{{ post.title }}</h3>
      <options-menu
        v-if="showOptionsMenu"
        v-on:deletePost="deletePost"
        :post-id="post.id"
        :posts-base-url="postsBaseUrl"
      />
    </div>
    <img class="ui image" v-bind:src="post.image.url" alt="placeholder">
    <p class="name-and-caption">
      <strong>{{ !post.posted_by ? 'anonymous' : post.posted_by }}</strong>
      <span v-if="!post.caption" class="no-caption">(no caption)</span>
      <span v-else>{{ post.caption }}</span>
    </p>
    <p class="created-at">{{ getDateRelativeToPresent(post.created_at) }}</p>
  </div>
</template>

<script>
import moment from "moment";
import OptionsMenu from "./options-menu";

export default {
  props: {
    post: { type: Object, required: true },
    postsBaseUrl: { type: String },
    showPage: { type: Boolean, required: false },
    showOptionsMenu: { type: Boolean, default: true }
  },
  components: {
    "options-menu": OptionsMenu
  },
  data() {
    return {
      deleted: false,
      loading: false
    };
  },
  methods: {
    getDateRelativeToPresent: function(originalDate) {
      return moment(originalDate).fromNow();
    },
    deletePost() {
      const shouldContinue = confirm(
        "Are you sure you would like to delete this post? This action cannot be undone"
      );

      if (!shouldContinue) {
        return;
      }

      this.loading = true;
      this.$http
        .delete(`/posts/${this.post.id}.json`)
        .then(res => (this.deleted = true))
        .catch(err => console.log(err))
        .finally(() => (this.loading = false));
    }
  }
};
</script>

<style scoped>
.post {
  margin: auto;
  margin-top: 2rem;
  max-width: 400px !important;
}
.title-area {
  display: flex;
  justify-content: space-between;
  align-items: center;
  min-height: 40px;
  overflow-wrap: break-word;
}
.title {
  padding: 0 0.75rem;
  margin: 0;
  transition: all 0.25s ease;
  font-size: 1.2rem;
  color: black;
}
a .title:hover {
  color: #3dc1cf;
}
.name-and-caption {
  padding: 0.75rem;
  padding-bottom: 0;
  margin: 0;
  overflow-wrap: break-word;
}
.no-caption {
  font-style: italic;
  color: #bbb;
  font-size: 0.85rem;
}
.created-at {
  font-style: italic;
  color: #aaa;
  display: block;
  margin: 0;
  font-size: 0.8rem;
  padding: 0.75rem;
  padding-top: 0.05rem;
}
.loading {
  text-align: center;
  margin: 50px 0 !important;
}
.loading-text {
  font-size: 1rem;
}
@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}
.spin-animation {
  animation: spin 2s infinite 0s;
}
.deleted {
  margin: 50px 0 !important;
}
</style>
