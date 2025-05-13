import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:epub_viewer/epub_viewer.dart';

Future<void> openBook(
  BuildContext context,
  String url,
  String bookTitle, {
  bool allowStreaming = true,
  bool allowDownload = false,
}) async {
  // Determine file type
  final isPdf = url.toLowerCase().endsWith('.pdf');
  final isEpub = url.toLowerCase().endsWith('.epub');
  print("Open");

  if (!isPdf && !isEpub) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content:
              Text('Unsupported file type. Only PDF and EPUB are allowed.')),
    );
    return;
  }

  final fileName = path.basename(url);
  final dir = await getApplicationDocumentsDirectory();
  final filePath = path.join(dir.path, fileName);
  final file = File(filePath);

  final fileExists = await file.exists();

  if (fileExists && !allowStreaming) {
    return _openFile(context, filePath, isPdf, bookTitle);
  }

  if (isPdf && allowStreaming) {
    // Stream PDF from the internet
    return _openFile(context, url, isPdf, bookTitle, fromUrl: true);
  }

  // EPUB always requires download or local access
  if (!fileExists) {
    await _downloadFile(
      context,
      url,
      filePath,
      showCancelButton: allowDownload,
    );
  }

  // After download, open the file
  if (await file.exists()) {
    _openFile(context, filePath, isPdf, bookTitle);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File download failed.')),
    );
  }
}

Future<void> _downloadFile(
  BuildContext context,
  String url,
  String savePath, {
  bool showCancelButton = false,
}) async {
  late StateSetter dialogSetState;
  double progress = 0;

  final cancelToken = Completer<void>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => StatefulBuilder(
      builder: (context, setState) {
        dialogSetState = setState;
        return AlertDialog(
          title: const Text('Downloading'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 12),
              Text('Progress: ${(progress * 100).toStringAsFixed(0)}%'),
            ],
          ),
          actions: showCancelButton
              ? [
                  TextButton(
                    onPressed: () {
                      cancelToken.complete();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  )
                ]
              : null,
        );
      },
    ),
  );

  try {
    final request = http.Request('GET', Uri.parse(url));
    final response = await http.Client().send(request);

    final file = File(savePath);
    final sink = file.openWrite();
    final total = response.contentLength ?? 0;
    int downloaded = 0;

    await for (final chunk in response.stream) {
      if (cancelToken.isCompleted) break;

      downloaded += chunk.length;
      sink.add(chunk);

      if (total > 0) {
        dialogSetState(() {
          progress = downloaded / total;
        });
      }
    }

    await sink.flush();
    await sink.close();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download failed: $e')),
    );
  } finally {
    if (context.mounted) Navigator.of(context).pop();
  }
}

void _openFile(
  BuildContext context,
  String pathOrUrl,
  bool isPdf,
  String bookTitle, {
  bool fromUrl = false,
}) {
  if (isPdf) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(bookTitle)),
          body: fromUrl
              ? SfPdfViewer.network(pathOrUrl)
              : SfPdfViewer.file(File(pathOrUrl)),
        ),
      ),
    );
  } else {
    // EPUB requires local file
    EpubViewer.setConfig(
      themeColor: Theme.of(context).primaryColor,
      allowSharing: true,
      enableTts: true,
    );
    EpubViewer.open(
      pathOrUrl,
      // title: bookTitle,
    );
  }
}
