// import 'dart:io';
// import 'package:epub_view/epub_view.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// class EpubViewerService {
//   /// Opens an EPUB file from either a URL or a local file path
//   /// Returns the EpubController that can be used with EpubView widget
//   static Future<EpubController> openBook({String? url, String? filePath}) async {
//     if (url == null && filePath == null) {
//       throw ArgumentError('Either url or filePath must be provided');
//     }
//
//     File epubFile;
//
//     if (url != null) {
//       // Download from URL to a temporary file
//       epubFile = await _downloadFromUrl(url);
//     } else {
//       // Use existing local file
//       epubFile = File(filePath!);
//     }
//
//     // Create and return an EpubController with the file
//     return EpubController(
//       document: EpubDocument.openFile(epubFile),
//     );
//   }
//
//   /// Helper method to download an EPUB file from a URL to local storage
//   static Future<File> _downloadFromUrl(String url) async {
//     try {
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         // Get temporary directory for storing the downloaded file
//         final dir = await getTemporaryDirectory();
//         final filePath = '${dir.path}/downloaded_${DateTime.now().millisecondsSinceEpoch}.epub';
//
//         // Write downloaded bytes to file
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         return file;
//       } else {
//         throw Exception('Failed to download EPUB: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error downloading EPUB file: $e');
//     }
//   }
// }