import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../domain/models/saved_schedule.dart';
import '../../domain/services/qr_share_service.dart';

/// Dialog for sharing a schedule via QR code
class QrShareDialog extends StatelessWidget {
  final SavedSchedule schedule;

  const QrShareDialog({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final qrData = QrShareService.scheduleToQrData(schedule);
    final isTooLarge = QrShareService.isTooLargeForQr(schedule);
    final dataSize = QrShareService.getDataSize(schedule);
    final compressionRatio = QrShareService.getCompressionRatio(schedule);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share via QR Code',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          schedule.name,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // QR Code or Warning
              if (isTooLarge)
                _buildTooLargeWarning(context, dataSize)
              else
                _buildQrCode(context, qrData),

              const SizedBox(height: 24),

              // Instructions
              if (!isTooLarge) ...[
                Text(
                  'Scan this QR code to import the schedule',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Compressed size: ${(dataSize / 1024).toStringAsFixed(1)} KB (${(compressionRatio * 100).toStringAsFixed(0)}% of original)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 16),

              // Copy JSON button
              OutlinedButton.icon(
                onPressed: () => _copyJson(context, qrData),
                icon: const Icon(Icons.copy),
                label: const Text('Copy as JSON'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrCode(BuildContext context, String qrData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: QrImageView(
        data: qrData,
        version: QrVersions.auto,
        size: 300,
        backgroundColor: Colors.white,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      ),
    );
  }

  Widget _buildTooLargeWarning(BuildContext context, int dataSize) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Schedule Too Large',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This schedule has too many classes (${(dataSize / 1024).toStringAsFixed(1)} KB) to fit in a QR code.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Try using "Copy as JSON" instead and share the text.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  void _copyJson(BuildContext context, String jsonData) {
    Clipboard.setData(ClipboardData(text: jsonData));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Schedule JSON copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
