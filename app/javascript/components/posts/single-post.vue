<template>
  <div class="post-wrapper">
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
      <p class="created-at">{{ getDateRelativeToPresent(post.created_at) }}</p>
    </div>
  </div>
</template>

<script>
import moment from "moment";

export default {
  props: {
    post: Object,
    postsBaseUrl: String,
    showPage: String
  },
  methods: {
    getDateRelativeToPresent: function(originalDate) {
      return moment(originalDate).fromNow();
    }
  }
};
</script>

<style scoped>
.post-wrapper {
  padding: 25px;
}
.post {
  margin: auto;
  margin-top: 2rem;
  max-width: 400px !important;
}
.header {
  padding: 0.85rem 0.75rem;
  margin: 0;
  transition: all 0.25s ease;
}
a:hover .header {
  color: #3dc1cf;
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
@media only screen and (max-width: 400px) {
  .post-wrapper {
    padding: 0;
  }
  .post {
    margin-top: 0;
  }
  .card {
    border-radius: 0 !important;
  }
}
</style>
