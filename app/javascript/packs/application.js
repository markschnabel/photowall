/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from "vue/dist/vue.esm";
import VueMasonry from 'vue-masonry-css'
import axios from "axios";

import SinglePost from "../components/posts/single-post";
import AllPosts from "../components/posts/all-posts";
import NewPostForm from "../components/post-form/new-post-form";
import EditPostForm from "../components/post-form/edit-post-form";

// Make axios accessible through the prototype "$http" in all components
Vue.prototype.$http = axios;

// Init masonry grid add-on
Vue.use(VueMasonry);

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: '[data-behavior="vue"]',
    components: { SinglePost, AllPosts, NewPostForm, EditPostForm }
  });
});
