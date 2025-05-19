// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:vocsy_epub_viewer/epub_viewer.dart';
//
// class BookViewer {
//   static Future<void> openBook(
//       BuildContext context,
//       String url,
//       String bookTitle, {
//         bool allowStreaming = true,
//         bool allowDownload = false,
//       }) async {
//     try {
//       // Determine file type
//       final isPdf = url.toLowerCase().endsWith('.pdf');
//       final isEpub = url.toLowerCase().endsWith('.epub');
//
//       if (!isPdf && !isEpub) {
//         _showError(context, 'Unsupported file type. Only PDF and EPUB are allowed.');
//         return;
//       }
//
//       final fileName = path.basename(url);
//       final dir = await getApplicationDocumentsDirectory();
//       final filePath = path.join(dir.path, fileName);
//       final file = File(filePath);
//
//       if (await file.exists() && !allowStreaming) {
//         return _openFile(context, filePath, isPdf, bookTitle);
//       }
//
//       if (isPdf && allowStreaming) {
//         return _openFile(context, url, isPdf, bookTitle, fromUrl: true);
//       }
//
//       if (!await file.exists()) {
//         await _downloadWithProgress(context, url, filePath, allowDownload);
//       }
//
//       if (await file.exists()) {
//         _openFile(context, filePath, isPdf, bookTitle);
//       } else {
//         _showError(context, 'File download failed.');
//       }
//     } catch (e) {
//       _showError(context, 'Error: ${e.toString()}');
//     }
//   }
//
//   static Future<void> _downloadWithProgress(
//       BuildContext context,
//       String url,
//       String savePath,
//       bool allowCancel,
//       ) async {
//     final completer = Completer<void>();
//     late StateSetter setState;
//     double progress = 0;
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => StatefulBuilder(
//         builder: (context, stateSetter) {
//           setState = stateSetter;
//           return AlertDialog(
//             title: const Text('Downloading'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(value: progress),
//                 const SizedBox(height: 16),
//                 Text('${(progress * 100).toStringAsFixed(1)}%'),
//               ],
//             ),
//             actions: allowCancel
//                 ? [TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 completer.complete();
//                 Navigator.pop(context);
//               },
//             )]
//                 : null,
//           );
//         },
//       ),
//     );
//
//     try {
//       final response = await http.get(Uri.parse(url));
//       final file = File(savePath);
//       await file.writeAsBytes(response.bodyBytes, flush: true);
//     } finally {
//       if (context.mounted) Navigator.pop(context);
//     }
//   }
//
//   static void _openFile(
//       BuildContext context,
//       String pathOrUrl,
//       bool isPdf,
//       String title, {
//         bool fromUrl = false,
//       }) {
//     if (isPdf) {
//       _openPdf(context, pathOrUrl, title, fromUrl: fromUrl);
//     } else {
//       _openEpub(context, pathOrUrl, title);
//     }
//   }
//
//   static void _openPdf(
//       BuildContext context,
//       String pathOrUrl,
//       String title, {
//         bool fromUrl = false,
//       }) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => Scaffold(
//           appBar: AppBar(title: Text(title)),
//           body: fromUrl
//               ? SfPdfViewer.network(pathOrUrl)
//               : SfPdfViewer.file(File(pathOrUrl)),
//         ),
//       ),
//     );
//   }
//
//   static void _openEpub(BuildContext context, String filePath, String title) {
//     VocsyEpub.setConfig(
//       themeColor: Theme.of(context).primaryColor,
//       identifier: "flutterEpub",
//       scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
//       allowSharing: true,
//       enableTts: true,
//       nightMode: Theme.of(context).brightness == Brightness.dark,
//     );
//
//     VocsyEpub.open(
//       filePath,
//       lastLocation: EpubLocator.fromJson({
//         "bookId": title,
//         "created": DateTime.now().millisecondsSinceEpoch,
//       }),
//     );
//   }
//
//   static void _showError(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
// }