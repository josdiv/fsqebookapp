// import 'package:epub_view/epub_view.dart';
// import 'package:flutter/material.dart';
//
// import '../../services/epub_viewer_service.dart';
//
// class EpubReaderScreen extends StatefulWidget {
//   final String? url;
//   final String? filePath;
//
//   const EpubReaderScreen({Key? key, this.url, this.filePath}) : super(key: key);
//
//   @override
//   _EpubReaderScreenState createState() => _EpubReaderScreenState();
// }
//
// class _EpubReaderScreenState extends State<EpubReaderScreen> {
//   EpubController? _epubController;
//   bool _isLoading = true;
//   String? _errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadBook();
//   }
//
//   Future<void> _loadBook() async {
//     try {
//       final controller = await EpubViewerService.openBook(
//         url: widget.url,
//         filePath: widget.filePath,
//       );
//
//       setState(() {
//         _epubController = controller;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('EPUB Reader'),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//           ? Center(child: Text('Error: $_errorMessage'))
//           : EpubView(
//         controller: _epubController!,
//       ),
//     );
//   }
// }