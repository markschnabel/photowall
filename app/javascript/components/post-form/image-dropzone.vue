<template>
  <div class="field">
    <label>Photo</label>
    <div class="dropzone">
      <input
        type="file"
        @change="changeImage"
        name="image"
        ref="imageInput"
        class="image-input"
        required
      >
      <!-- @change="handleDrop" -->
      <div v-if="image && filename">
        <p class="preview-text">You uploaded:</p>
        <img :src="image" alt="Your Image" class="image-preview">
        <p class="filename">{{ filename }}</p>
        <p class="upload-instruction">Drag and drop a photo here or click to use a different image</p>
      </div>
      <div v-else>
        <i class="cloud upload icon big" v-if="!this.image"></i>
        <p class="upload-instruction">Drag and drop a photo here or click to upload</p>
      </div>
    </div>
    <p v-if="errorMessage" class="helper-text helper-text-error">Image {{ errorMessage }}</p>
    <p
      v-else
      class="helper-text"
    >The image you would like to upload. Required. Must use one of the following extensions: .png, .jpeg, .gif or .jpg</p>
  </div>
</template>

<script>
import {
  hasValidMimeType,
  hasValidExtension,
  isValidFileSize
} from "../../utils/validators";

export default {
  props: {
    image: String,
    filename: String,
    errorMessage: String
  },
  methods: {
    changeImage() {
      const file = this.$refs.imageInput.files[0];

      // Check the type of the file
      if (!hasValidMimeType(file) || !hasValidExtension(file.name)) {
        this.$emit(
          "changeImageError",
          "must be of one of the following types: .jpg, .jpeg, .png or .gif"
        );
      } else if (!isValidFileSize(file.size)) {
        this.$emit("changeImageError", "is too large (max size is 5MB).");
      } else {
        this.$emit("changeImage", file);
      }
    },
    checkIfValidImage(file) {
      return hasValidMimeType(file) && hasValidExtension(file.name);
    }
  }
};
</script>

<style scoped>
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
  height: 200px;
  transition: all 0.5s ease;
  position: relative;
}
.dropzone:hover {
  background: #ececec;
}
.image-input {
  opacity: 0;
  width: 100%;
  height: inherit;
  position: absolute;
  cursor: pointer;
}
.upload-instruction {
  font-weight: 600;
}
.image-preview {
  width: 100px;
  height: 100px;
  object-fit: cover;
  padding-bottom: 2.5px;
}
.preview-text {
  margin-bottom: 5px;
  font-weight: 600;
}
.filename {
  text-overflow: ellipsis;
  max-width: 80%;
  white-space: nowrap;
  overflow: hidden !important;
  margin: 0 auto;
  padding-bottom: 2px;
}
.post-link {
  text-decoration: underline;
  color: #1a531b !important;
  transition: all 0.25s ease;
}
.post-link:hover {
  color: rgb(9, 27, 9) !important;
}
</style>
