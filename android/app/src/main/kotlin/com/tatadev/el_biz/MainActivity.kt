package com.tatadev.el_biz

import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream

class MainActivity: FlutterActivity() {
    private val DOWNLOAD_CHANNEL = "excel_downloader"
    private val SCAN_CHANNEL = "media_scanner"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Channel for saving Excel files to public Downloads (MediaStore)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DOWNLOAD_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "saveExcel" -> {
                    try {
                        val bytes = call.argument<ByteArray>("bytes")
                        val filename = call.argument<String>("filename") ?: "file.xlsx"

                        if (bytes == null) {
                            result.error("NO_BYTES", "No bytes provided", null)
                            return@setMethodCallHandler
                        }

                        val savedUri = saveExcelToDownloads(bytes, filename)
                        result.success(savedUri.toString())
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }

        // Existing channel to trigger media scan (keeps previous behavior)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SCAN_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "scanFile" -> {
                    val filePath = call.argument<String>("path")
                    if (filePath != null) {
                        try {
                            scanFile(filePath)
                            result.success("Media scan triggered for: $filePath")
                        } catch (e: Exception) {
                            result.error("SCAN_ERROR", e.message, null)
                        }
                    } else {
                        result.error("INVALID_PATH", "File path is null", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    /**
     * Save bytes into the public Downloads folder.
     * Uses MediaStore for Android Q+ (API 29+); for older versions writes directly to
     * Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).
     *
     * Returns the Uri of the saved file.
     */
    private fun saveExcelToDownloads(bytes: ByteArray, fileName: String): Uri {
        val resolver = applicationContext.contentResolver

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            // Use MediaStore (recommended for Android 10+)
            val contentValues = ContentValues().apply {
                put(MediaStore.Downloads.DISPLAY_NAME, fileName)
                put(MediaStore.Downloads.MIME_TYPE, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
                put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS) // "Download/"
                put(MediaStore.Downloads.IS_PENDING, 1)
            }

            val collection = MediaStore.Downloads.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
            val itemUri = resolver.insert(collection, contentValues)
                ?: throw Exception("Failed to create new MediaStore record.")

            // Write bytes
            resolver.openOutputStream(itemUri).use { out: OutputStream? ->
                out?.write(bytes)
                out?.flush()
            }

            // Mark as not pending
            contentValues.clear()
            contentValues.put(MediaStore.Downloads.IS_PENDING, 0)
            resolver.update(itemUri, contentValues, null, null)

            return itemUri
        } else {
            // For older Android versions, write directly to Downloads folder
            val downloadsDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
            if (!downloadsDir.exists()) {
                downloadsDir.mkdirs()
            }
            val outFile = File(downloadsDir, fileName)
            FileOutputStream(outFile).use { fos ->
                fos.write(bytes)
                fos.flush()
            }

            // Trigger media scanner so file shows up
            val uri = Uri.fromFile(outFile)
            val intent = Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE)
            intent.data = uri
            sendBroadcast(intent)

            return uri
        }
    }

    /**
     * Trigger media scanner for a file path (keeps your previous functionality).
     */
    private fun scanFile(filePath: String) {
        try {
            val file = File(filePath)
            if (file.exists()) {
                val uri = Uri.fromFile(file)
                val intent = Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE)
                intent.data = uri
                sendBroadcast(intent)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
