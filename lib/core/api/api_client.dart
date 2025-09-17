import 'package:dio/dio.dart';
import 'package:foursquare_ebbok_app/core/api/api_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  Dio getDio() {
    Dio dio = Dio();
    dio.options.baseUrl = ApiConfig.baseUrl;

    dio.interceptors.add(
      PrettyDioLogger(
        responseHeader: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        request: true,
        compact: false,
      ),
    );

    return dio;
  }
}
