<template>
  <div class="ui card post">
    <a v-if="postsBaseUrl" v-bind:href="`${postsBaseUrl}/${post.id}`">
      <h3 class="ui header">{{ post.title }}</h3>
    </a>
    <h3 v-else class="ui header">{{ post.title }}</h3>
    <img class="ui image" v-bind:src="post.image.url" alt="placeholder">
    <p class="name-and-caption">
      <strong>{{ post.posted_by }}</strong>
      {{ post.caption }}
    </p>
    <p class=" created-at">{{ getDateRelativeToPresent(post.created_at) }}</p>
  </div>
</template>

<script>
import moment from 'moment'

export default {
  props: {
    post: Object,
    postsBaseUrl: String
  },
  methods: {
    getDateRelativeToPresent: function(originalDate) {
      return moment(originalDate).fromNow();
    }
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
.name-and-caption {
  padding: 0.75rem;
  padding-bottom: 0;
  margin: 0;
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
</style>
