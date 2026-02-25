import 'dart:convert';
import '../models/saved_schedule.dart';

/// Service for sharing schedules via QR codes
class QrShareService {
  /// Convert a schedule to a QR-friendly string
  static String scheduleToQrData(SavedSchedule schedule) {
    final json = schedule.toJson();
    final jsonString = jsonEncode(json);

    // Compress by removing unnecessary whitespace
    return jsonString;
  }

  /// Parse QR data back to a schedule
  static SavedSchedule? qrDataToSchedule(String qrData) {
    try {
      final json = jsonDecode(qrData) as Map<String, dynamic>;
      return SavedSchedule.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Generate a shareable link format (base64 encoded)
  static String generateShareLink(SavedSchedule schedule) {
    final qrData = scheduleToQrData(schedule);
    final bytes = utf8.encode(qrData);
    final base64String = base64Encode(bytes);

    // Prefix to identify it as a schedule link
    return 'schedbuilder://$base64String';
  }

  /// Parse a share link back to schedule
  static SavedSchedule? parseShareLink(String link) {
    try {
      if (!link.startsWith('schedbuilder://')) {
        return null;
      }

      final base64String = link.substring('schedbuilder://'.length);
      final bytes = base64Decode(base64String);
      final qrData = utf8.decode(bytes);

      return qrDataToSchedule(qrData);
    } catch (e) {
      return null;
    }
  }

  /// Get estimated QR code data size
  static int getDataSize(SavedSchedule schedule) {
    final qrData = scheduleToQrData(schedule);
    return qrData.length;
  }

  /// Check if schedule is too large for QR code
  /// QR codes support up to ~4000 characters
  static bool isTooLargeForQr(SavedSchedule schedule) {
    return getDataSize(schedule) > 3500; // Leave some margin
  }
}
