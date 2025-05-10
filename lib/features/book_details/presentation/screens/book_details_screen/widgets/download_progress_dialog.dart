import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void showDownloadProgress(BuildContext context, double progress) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 5.0,
            percent: progress / 100,
            center: Text('${progress.toStringAsFixed(0)}%'),
          ),
          const SizedBox(height: 16),
          Text(progress < 100 ? 'Downloading...' : 'Download Complete!'),
        ],
      ),
      actions: progress >= 100
          ? [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ]
          : null,
    ),
  );
}