import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DownloadProgressDialog extends StatefulWidget {
  final Stream<double> downloadProgressStream;

  const DownloadProgressDialog({super.key, required this.downloadProgressStream});

  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    widget.downloadProgressStream.listen((progress) {
      setState(() {
        _progress = progress;
      });
      if (_progress >= 100) {
        // Automatically close the dialog after a short delay
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularPercentIndicator(
            radius: 50.0, // Slightly larger for better visibility
            lineWidth: 7.0,
            percent: _progress / 100,
            center: Text('${_progress.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 16)), // Slightly larger text
            progressColor: Theme.of(context).colorScheme.primary, // Use theme color
          ),
          const SizedBox(height: 16),
          Text(
            _progress < 100 ? 'Downloading...' : 'Download Complete!',
            style: const TextStyle(fontWeight: FontWeight.bold), // Make the status text stand out
          ),
        ],
      ),
    );
  }
}

void showDownloadProgress(BuildContext context, Stream<double> downloadProgressStream) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => DownloadProgressDialog(downloadProgressStream: downloadProgressStream),
  );
}