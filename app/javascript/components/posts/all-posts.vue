<template>
  <div class="wrapper">
    <h1 class="header"><i class="camera retro icon"></i>Photowall</h1>
    <p class="tagline">A public image board</p>
    <div v-if="posts && posts.length > 0">
      <masonry :cols="{default: 5, 1800: 4, 1200: 3, 900: 2, 600: 1}" :gutter="40">
        <single-post
          v-for="post in posts"
          v-bind:post="post"
          v-bind:posts-base-url="postsBaseUrl"
          v-bind:key="post.id"
        />
      </masonry>
    </div>
    <div v-else-if="posts && posts.length === 0" class="message-wrapper">
      <div class="ui blue message">
        <div class="header">Hm, it seems there's no posts yet!</div>
        <p>
          <a v-bind:href="newPostUrl" class="new-post-link">Click here</a> to be the first!
        </p>
      </div>
    </div>
    <div v-else class="ui active dimmer inverted">
      <div class="ui large text loader">Loading</div>
    </div>
  </div>
</template>

<script>
import SinglePost from "./single-post";

export default {
  name: "all-posts",
  components: { "single-post": SinglePost },
  props: {
    postsBaseUrl: String,
    newPostUrl: String
  },
  data() {
    return {
      posts: null
    };
  },
  beforeMount() {
    this.loadPosts();
  },
  methods: {
    async loadPosts() {
      let posts = await this.$http.get("/posts.json").then(res => res.data);
      this.posts = posts;
    }
  }
};
</script>

<style scoped>
.dimmer {
  z-index: 0 !important; /* Make loader display below navbar*/
}
.header {
  text-align: center;
  margin-bottom: 2px;
}
.tagline {
  font-size: 0.85rem;
  font-style: italic;
  text-align: center;
  margin-bottom: 35px;
  color: #aaa;
}
.message-wrapper {
  max-width: 800px;
  margin: auto;
  padding: 0 10px;
  text-align: center;

}
.new-post-link {
  text-decoration: underline;
  color: midnightblue !important;
  transition: all 0.25s ease;
  cursor: pointer;
}
.new-post-link:hover {
  color: rgb(2, 1, 12) !important;
}
</style>
