const ALLOWED_MIME_TYPES = ["image/jpeg", "image/png", "image/gif"];
const ALLOWED_EXTENSIONS = [".jpg", ".jpeg", ".png", ".gif"];
const MAX_FILE_SIZE = 5000000;

export function hasValidMimeType(file) {
  return ALLOWED_MIME_TYPES.includes(file.type);
}
export function hasValidExtension(filename) {
  filename = filename.toLowerCase();

  for (let i = 0; i < ALLOWED_EXTENSIONS.length; i++) {
    if (filename.endsWith(ALLOWED_EXTENSIONS[i])) {
      return true;
    }
  }

  return false;
}
export function isValidFileSize(fileSize) {
  return fileSize <= MAX_FILE_SIZE;
}
