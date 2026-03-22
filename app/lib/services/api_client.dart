import 'package:dio/dio.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:5000/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
      responseType: ResponseType.json,
    ),
  );

  static bool _isInitialized = false;

  static Dio get instance {
    if (!_isInitialized) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print("REQUEST[${options.method}] => ${options.uri}");
            return handler.next(options);
          },
          onResponse: (response, handler) {
            print("RESPONSE[${response.statusCode}] => ${response.data}");
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            print("ERROR[${e.response?.statusCode}] => ${e.message}");
            return handler.next(e);
          },
        ),
      );

      _isInitialized = true;
    }

    return _dio;
  }
}
