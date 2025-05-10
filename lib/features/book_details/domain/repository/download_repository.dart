import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_details_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsRepository {
  static const _boxName = 'downloadedBooks';
  static late Box<Map<String, dynamic>> _box;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox<Map<String, dynamic>>(_boxName);
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
    return _box.values.map((map) => Book.fromMap(map)).toList();
  }

  static Future<void> removeDownload(String bookId) async {
    await _box.delete(bookId);
  }
}