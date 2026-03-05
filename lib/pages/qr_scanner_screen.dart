import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../../domain/services/qr_share_service.dart';
import '../../domain/models/saved_schedule.dart';
import '../providers/saved_schedules_provider.dart';
import 'schedule_comparison_screen.dart';

/// Screen for scanning QR codes to import schedules
class QrScannerScreen extends StatefulWidget {
  final bool comparisonMode;
  final SavedSchedule? mySchedule;

  const QrScannerScreen({
    super.key,
    this.comparisonMode = false,
    this.mySchedule,
  });

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isProcessing = false;
  final List<SavedSchedule> _scannedSchedules = [];

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.comparisonMode ? 'Scan to Compare' : 'Scan QR Code'),
        actions: [
          if (widget.comparisonMode && _scannedSchedules.isNotEmpty)
            IconButton(
              icon: Badge(
                label: Text('${_scannedSchedules.length}'),
                child: const Icon(Icons.compare_arrows),
              ),
              onPressed: _showComparison,
              tooltip: 'Compare schedules',
            ),
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
            tooltip: 'Toggle flash',
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => cameraController.switchCamera(),
            tooltip: 'Switch camera',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera view
          MobileScanner(controller: cameraController, onDetect: _onDetect),

          // Overlay with scanning area
          CustomPaint(painter: _ScannerOverlayPainter(), child: Container()),

          // Instructions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.comparisonMode
                        ? 'Scan QR codes to compare schedules'
                        : 'Position QR code within the frame',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.comparisonMode
                        ? _scannedSchedules.isEmpty
                              ? 'Scan friend\'s schedules to find common free time'
                              : 'Scanned ${_scannedSchedules.length} schedule(s). Tap compare button above.'
                        : 'The schedule will be imported automatically',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    setState(() => _isProcessing = true);

    // Try to parse the QR code
    final schedule = QrShareService.qrDataToSchedule(code);

    if (schedule != null) {
      if (widget.comparisonMode) {
        _addToComparison(schedule);
      } else {
        _importSchedule(schedule);
      }
    } else {
      _showError('Invalid QR code. This is not a valid schedule.');
    }
  }

  Future<void> _importSchedule(dynamic schedule) async {
    try {
      final savedSchedulesProvider = context.read<SavedSchedulesProvider>();

      // Check if schedule with same name already exists
      final existingSchedules = savedSchedulesProvider.schedules;
      final nameExists = existingSchedules.any((s) => s.name == schedule.name);

      if (nameExists) {
        // Generate new name
        var newName = '${schedule.name} (imported)';
        var counter = 1;
        while (existingSchedules.any((s) => s.name == newName)) {
          newName = '${schedule.name} (imported $counter)';
          counter++;
        }
        schedule = schedule.copyWith(name: newName);
      }

      await savedSchedulesProvider.saveScheduleFromImport(schedule);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Schedule "${schedule.name}" imported successfully'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      _showError('Failed to import schedule: $e');
    }
  }

  void _showError(String message) {
    if (!mounted) return;

    setState(() => _isProcessing = false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Try Again'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close scanner
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _addToComparison(SavedSchedule schedule) {
    setState(() {
      _scannedSchedules.add(schedule);
      _isProcessing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "${schedule.name}" to comparison'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _scannedSchedules.removeLast();
            });
          },
        ),
      ),
    );
  }

  void _showComparison() {
    // Add my schedule if provided
    final schedulesToCompare = <SavedSchedule>[
      if (widget.mySchedule != null) widget.mySchedule!,
      ..._scannedSchedules,
    ];

    if (schedulesToCompare.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Need at least 2 schedules to compare'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Navigate to comparison screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ScheduleComparisonScreen(schedules: schedulesToCompare),
      ),
    );
  }
}

/// Custom painter for scanner overlay
class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final scanAreaSize = size.width * 0.7;
    final scanAreaLeft = (size.width - scanAreaSize) / 2;
    final scanAreaTop = (size.height - scanAreaSize) / 2;

    // Draw darkened area around scan zone
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(
        Rect.fromLTWH(scanAreaLeft, scanAreaTop, scanAreaSize, scanAreaSize),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    // Draw corner brackets
    final cornerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final cornerLength = 30.0;

    // Top-left corner
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + cornerLength),
      Offset(scanAreaLeft, scanAreaTop),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop),
      Offset(scanAreaLeft + cornerLength, scanAreaTop),
      cornerPaint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize - cornerLength, scanAreaTop),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + cornerLength),
      cornerPaint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + scanAreaSize - cornerLength),
      Offset(scanAreaLeft, scanAreaTop + scanAreaSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + scanAreaSize),
      Offset(scanAreaLeft + cornerLength, scanAreaTop + scanAreaSize),
      cornerPaint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(
        scanAreaLeft + scanAreaSize - cornerLength,
        scanAreaTop + scanAreaSize,
      ),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + scanAreaSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(
        scanAreaLeft + scanAreaSize,
        scanAreaTop + scanAreaSize - cornerLength,
      ),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + scanAreaSize),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
