<template>
  <div>
    <button @click="toggleDropdown" class="toggle-button">
      <i class="icon ellipsis horizontal large"></i>
    </button>
    <div :class="showDropdown ? 'dropdown-menu' : 'dropdown-menu hidden'">
      <a v-bind:href="`${postsBaseUrl}/${postId}/edit`">
        <div class="menu-item">
          <i class="icon pencil"></i>
          Edit
        </div>
      </a>
      <div @click="deletePost" class="menu-item">
        <i class="icon trash"></i>
        Delete
      </div>
      <div @click="toggleDropdown" class="menu-item">
        <i class="icon close"></i>
        Close
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    postsBaseUrl: String,
    postId: Number
  },
  data() {
    return {
      showDropdown: false
    };
  },
  methods: {
    toggleDropdown() {
      this.showDropdown = !this.showDropdown;
    },
    deletePost() {
      this.$emit("deletePost");
    }
  }
};
</script>

<style scoped>
.toggle-button {
  cursor: pointer;
  background: transparent;
  border: none;
  margin: 0 5px;
}
.dropdown-menu {
  position: absolute;
  background: white;
  border: solid 1px #aaa;
  border-radius: 5px;
  z-index: 500;
  width: 110px;
  margin-top: 3px;
  -webkit-box-shadow: 1px 1px 2px 0px rgba(0, 0, 0, 0.75);
  -moz-box-shadow: 1px 1px 2px 0px rgba(0, 0, 0, 0.75);
  box-shadow: 1px 1px 2px 0px rgba(0, 0, 0, 0.75);
}
.hidden {
  display: none;
}
.menu-item {
  padding: 5px;
  transition: all 0.5s ease;
  font-weight: 600;
  cursor: pointer;
  color: #222;
}
.menu-item:hover {
  background: #ccc;
}
</style>
