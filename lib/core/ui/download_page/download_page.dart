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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const Text(
                      textAlign: TextAlign.center,
                      "You are in offline mode and can only access downloaded book",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: downloads.length,
                      itemBuilder: (context, index) {
                        final book = downloads[index];

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
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/book_placeholder.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
