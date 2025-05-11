import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_details_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsRepository {
  static const _boxName = 'downloadedBooks';
  static late Box<Map<dynamic, dynamic>> _box; // Changed to dynamic keys

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox(_boxName); // Remove explicit type
  }

  static bool isBookDownloaded(String bookId) {
    return _box.containsKey(bookId);
  }

  static Future<void> saveDownload(BookDetailsEntity book, String path) async {
    await _box.put(book.bookId, {
      'id': book.bookId,
      'title': book.bookTitle,
      'author': book.authorName,
      'coverUrl': book.bookImg,
      'path': path,
      'downloadedAt': DateTime.now().toIso8601String(),
    });
  }

  static List<Book> getDownloads() {
    return _box.values.map((map) {
      // Safe conversion with null checks
      try {
        return Book.fromMap(Map<String, dynamic>.from(map));
      } catch (e) {
        debugPrint('Error converting downloaded book: $e');
        return Book.empty(); // Ensure your Book class has an empty constructor
      }
    }).toList();
  }

  static Future<void> removeDownload(String bookId) async {
    await _box.delete(bookId);
  }
}