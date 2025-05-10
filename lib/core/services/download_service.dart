import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  static Future<String> downloadFile({
    required String url,
    required String fileName,
    required Function(double) onProgress,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$fileName';

    try {
      final dio = Dio();
      await dio.download(
        url,
        path,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total * 100);
          }
        },
      );
      return path;
    } catch (e) {
      throw Exception('Download failed: $e');
    }
  }
}