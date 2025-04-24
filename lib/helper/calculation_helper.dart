String formatBytes(int bytes) {
  if (bytes >= 1024 * 1024) {
    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
  } else if (bytes >= 1024) {
    return "${(bytes / 1024).toStringAsFixed(2)} KB";
  } else {
    return "$bytes B";
  }
}
