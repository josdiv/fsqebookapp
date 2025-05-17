// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
// import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//
// class PdfViewerScreen extends StatefulWidget {
//   const PdfViewerScreen({super.key, required this.title});
//   final String title;
//
//   @override
//   State<PdfViewerScreen> createState() => _PdfViewerScreenState();
// }
//
// class _PdfViewerScreenState extends State<PdfViewerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final epubController = EpubController();
//
//     var textSelectionCfi = '';
//
//     bool isLoading = true;
//
//     double progress = 0.0;
//
//     return BlocBuilder<BookDetailsCubit, BookDetailsState>(
//       builder: (context, state) {
//         final model = state.model;
//         final readBookModel = model.readBookModel;
//         final isPdf = readBookModel.entity.isPdf;
//
//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             title: Text(widget.title, style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold
//             ),),
//             backgroundColor: Colors.white,
//           ),
//           body: isPdf
//               ? SfPdfViewer.network(readBookModel.entity.bookUrl)
//               : SafeArea(
//                   child: Column(
//                   children: [
//                     LinearProgressIndicator(
//                       value: progress,
//                       backgroundColor: Colors.transparent,
//                     ),
//                     Expanded(
//                       child: Stack(
//                         children: [
//                           EpubViewer(
//                             epubSource: EpubSource.fromUrl(
//                                 readBookModel.entity.bookUrl),
//                             epubController: epubController,
//                             displaySettings: EpubDisplaySettings(
//                                 flow: EpubFlow.paginated,
//                                 useSnapAnimationAndroid: false,
//                                 snap: true,
//                                 theme: EpubTheme.light(),
//                                 allowScriptedContent: true),
//                             selectionContextMenu: ContextMenu(
//                               menuItems: [
//                                 ContextMenuItem(
//                                   title: "Highlight",
//                                   id: 1,
//                                   action: () async {
//                                     epubController.addHighlight(
//                                         cfi: textSelectionCfi);
//                                   },
//                                 ),
//                               ],
//                               settings: ContextMenuSettings(
//                                   hideDefaultSystemContextMenuItems: true),
//                             ),
//                             onChaptersLoaded: (chapters) {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             },
//                             onEpubLoaded: () async {
//                               print('Epub loaded');
//                             },
//                             onRelocated: (value) {
//                               print("Reloacted to $value");
//                               setState(() {
//                                 progress = value.progress;
//                               });
//                             },
//                             onAnnotationClicked: (cfi) {
//                               print("Annotation clicked $cfi");
//                             },
//                             onTextSelected: (epubTextSelection) {
//                               textSelectionCfi = epubTextSelection.selectionCfi;
//                               print(textSelectionCfi);
//                             },
//                           ),
//                           Visibility(
//                             visible: isLoading,
//                             child: const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//         );
//       },
//     );
//   }
// }
