<template>
  <div class="wrapper">
    <div v-if="posts.length > 0">
      <Post
        v-for="post in posts"
        v-bind:post="post"
        v-bind:posts-url="postsUrl"
        v-bind:key="post.id"
      />
    </div>
    <div v-else class="ui active dimmer inverted">
      <div class="ui large text loader">Loading</div>
    </div>
  </div>
</template>

<script>
import Post from "./post";

export default {
  name: "all-posts",
  components: { Post },
  props: { postsUrl: String },
  data() {
    return {
      posts: []
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
</style>
