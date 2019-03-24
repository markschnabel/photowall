<template>
  <div class="post-form-wrapper">
    <h1>Create a new post</h1>
    <form
      v-bind:class="!uploading ? 'ui form' : 'ui form loading'"
      @submit="(e) => sendDataToServer(e)"
    >
      <div class="field">
        <label>Title</label>
        <input
          type="text"
          placeholder="A Big Giant Huge Photo"
          v-model="title"
          name="title"
          required
        >
        <p class="helper-text">Give your post a title</p>
      </div>
      <div class="field ui form">
        <label>Photo</label>
        <div class="dropzone">
          <input type="file" name="image" ref="imageInput" @change="handleDrop" class="image-input">
          <img
            v-if="this.image"
            :src="this.image"
            alt="Your Image"
            class="image-preview"
          >
          <i class="cloud upload icon big"></i>
          <h4>Drag and drop a photo here or click to upload</h4>
        </div>
      </div>
      <div class="field">
        <label>Your Name</label>
        <input type="text" placeholder="George W. Bush" v-model="postedBy" name="posted_by">
        <p class="helper-text">Your real name or a screen name. Defaults to "anonymous".</p>
      </div>
      <div class="field">
        <label>Caption</label>
        <textarea
          placeholder="This photo is big. So big, you have no idea."
          v-model="caption"
          name="caption"
        />
        <p class="helper-text">Describe your photo</p>
      </div>
      <button class="ui submit button" type="submit">Submit</button>
    </form>
  </div>
</template>

<script>
export default {
  name: "app",
  data() {
    return {
      image: "",
      title: "",
      postedBy: "",
      caption: "",
      uploading: false
    };
  },
  methods: {
    async sendDataToServer(e) {
      e.preventDefault();
      this.uploading = true;

      console.log(this.image);

      const post = {
        title: this.title,
        image: this.image,
        posted_by: this.postedBy,
        caption: this.caption
      };

      console.log(post);

      let posts = await this.$http
        .post("/posts.json", post)
        .then(res => console.log(res.data))
        .catch(err => console.log(err))
        .finally(() => (this.uploading = false));
    },
    handleDrop() {
      this.uploading = true;

      const rawImage = this.$refs.imageInput.files[0];

      const fileReader = new FileReader();
      fileReader.addEventListener("load", () => {
        this.image = fileReader.result;
      });

      fileReader.readAsDataURL(rawImage);

      this.uploading = false;
    }
  }
};
</script>

<style scoped>
.post-form-wrapper {
  margin: auto;
  max-width: 800px;
  padding: 0 10px;
}
.helper-text {
  font-size: 0.85em;
  color: #999;
  font-style: italic;
  margin-left: 5px;
}
.dropzone {
  border: 1px solid #dfdfdf;
  /* This is apparently what semantic ui uses for a border radius */
  border-radius: 0.28571429rem;
  text-align: center;
  color: #ccc;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 200px;
  transition: all 0.5s ease;
}
.image-input {
  opacity: 0;
  width: 100%;
  height: 100%;
  position: absolute;
  cursor: pointer;
}
.dropzone:hover {
  background: #ececec;
}
.dropzone h4 {
  margin: 0;
  display: block;
}
.image-preview {
  width: 100px;
  height: 100px;
  object-fit: cover;
  padding-bottom: 10px;
}
</style>
