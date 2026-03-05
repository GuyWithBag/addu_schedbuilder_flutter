import 'dart:convert';
import 'dart:io';
import '../models/saved_schedule.dart';

/// Service for sharing schedules via QR codes
class QrShareService {
  /// Convert a schedule to a QR-friendly compressed string
  static String scheduleToQrData(SavedSchedule schedule) {
    final json = schedule.toJson();
    final jsonString = jsonEncode(json);

    // Compress using gzip
    final bytes = utf8.encode(jsonString);
    final compressed = gzip.encode(bytes);
    final base64Compressed = base64Encode(compressed);

    // Add prefix to identify compressed data
    return 'gz:$base64Compressed';
  }

  /// Parse QR data back to a schedule
  static SavedSchedule? qrDataToSchedule(String qrData) {
    try {
      String jsonString;

      // Check if data is compressed
      if (qrData.startsWith('gz:')) {
        // Decompress gzipped data
        final base64Data = qrData.substring(3);
        final compressed = base64Decode(base64Data);
        final decompressed = gzip.decode(compressed);
        jsonString = utf8.decode(decompressed);
      } else {
        // Legacy uncompressed data
        jsonString = qrData;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SavedSchedule.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Generate a shareable link format (compressed and base64 encoded)
  static String generateShareLink(SavedSchedule schedule) {
    final qrData = scheduleToQrData(schedule);
    // Already compressed and base64 encoded, just add protocol
    return 'schedbuilder://$qrData';
  }

  /// Parse a share link back to schedule
  static SavedSchedule? parseShareLink(String link) {
    try {
      if (!link.startsWith('schedbuilder://')) {
        return null;
      }

      final qrData = link.substring('schedbuilder://'.length);
      return qrDataToSchedule(qrData);
    } catch (e) {
      return null;
    }
  }

  /// Get estimated QR code data size (compressed)
  static int getDataSize(SavedSchedule schedule) {
    final qrData = scheduleToQrData(schedule);
    return qrData.length;
  }

  /// Check if schedule is too large for QR code
  /// QR codes support up to ~4000 characters in binary mode
  /// Using alphanumeric mode we get ~2950 characters max
  /// With compression, we can fit much larger schedules
  static bool isTooLargeForQr(SavedSchedule schedule) {
    return getDataSize(schedule) >
        2900; // Conservative limit for alphanumeric QR
  }

  /// Get compression ratio for debugging
  static double getCompressionRatio(SavedSchedule schedule) {
    final json = schedule.toJson();
    final jsonString = jsonEncode(json);
    final originalSize = jsonString.length;
    final compressedSize = getDataSize(schedule);

    return compressedSize / originalSize;
  }
}
