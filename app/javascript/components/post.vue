<template>
  <div class="ui card post">
    <a v-if="postsUrl" v-bind:href="`${postsUrl}/${post.id}`">
      <h3 class="ui header">{{ post.title }}</h3>
    </a>
    <h3 v-else class="ui header">{{ post.title }}</h3>
    <img class="ui image" v-bind:src="post.image.url" alt="placeholder">
    <p class="caption">
      <strong>{{ post.posted_by }}</strong>
      {{ post.caption }}
    </p>
  </div>
</template>

<script>
export default {
  name: "Post",
  props: {
    post: Object,
    postsUrl: String
  }
};
</script>

<style scoped>
.post {
  margin: auto;
  margin-top: 2rem;
}
.header {
  padding: 0.85rem 0.75rem;
  margin: 0;
  transition: all 0.25s ease;
}
a:hover .header {
  color: #3dc1cf;
}

.card {
  max-width: 100%;
  width: 500px !important;
}
.caption {
  padding: 0.75rem;
}
</style>
