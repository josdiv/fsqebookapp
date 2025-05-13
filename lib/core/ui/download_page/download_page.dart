import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';

import '../../../features/book_details/domain/repository/download_repository.dart';
import '../../utils/open_book/open_book.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var downloads = DownloadsRepository.getDownloads();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Downloads',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.redColor,
      ),
      backgroundColor: Colors.white,
      body: downloads.isEmpty
          ? const Center(child: Text("No books downloaded"))
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: ListView.builder(
                itemCount: downloads.length,
                itemBuilder: (context, index) {
                  final book = downloads[index];
                  // final myBook = DownloadsRepository.getSingleBook(book.id);

                  // return ListTile(
                  //   leading: const Icon(Icons.book),
                  //   title: Text(book.title),
                  //   onTap: () => openBook(
                  //       context, book.path, allowStreaming: false, book.title),
                  // );
                  // return Card(
                  //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   child: ListTile(
                  //     leading: SizedBox(
                  //       width: 50,
                  //       height: 70,
                  //       // Display book cover if available
                  //       child: book.coverUrl != null
                  //           ? Image.network(
                  //         book.coverUrl,
                  //         fit: BoxFit.cover,
                  //         errorBuilder: (context, error, stackTrace) =>
                  //         const Icon(Icons.book, size: 40),
                  //       )
                  //           : const Icon(Icons.book, size: 40),
                  //     ),
                  //     title: Text(
                  //       book.title,
                  //       style: const TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     subtitle: Text(book.author),
                  //     onTap: () {
                  //       // Implement logic to open the locally stored book
                  //       // print('Opening book: ${book.filePath}');
                  //       // You'll likely need a plugin like `open_filex` or platform-specific code
                  //       // to open the file.
                  //     },
                  //   ),
                  // );

                  return InkWell(
                    onTap: () {
                      openBook(
                        context,
                        book.path,
                        allowStreaming: false,
                        book.title,
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/book_placeholder.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    book.author,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: 1.0,
                                    backgroundColor: Colors.grey[200],
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 4),
                                  // Text(
                                  //   '${((book['progress'] as double) * 100).toStringAsFixed(0)}% read',
                                  //   style: TextStyle(
                                  //     color: Colors.grey[600],
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            // IconButton(
                            //   icon: const Icon(Icons.play_arrow),
                            //   onPressed: () {
                            //     // Open book for reading
                            //     /**/
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
