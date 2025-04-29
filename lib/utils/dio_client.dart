import 'package:dio/dio.dart';

import 'api_error.dart';
import 'constants.dart';
import 'shared_prefs.dart';

class DioClient {
  DioClient._();

  static Dio _dio = Dio();

  static Dio getInstance() {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    Future.delayed(
      const Duration(microseconds: 300),
      () async {
        final token = await SharedPrefs().getAccessToken();
        if (token != "") {
          headers.putIfAbsent('Authorization', () => 'Bearer $token');
        }
      },
    );

    _dio = Dio()
      ..options.baseUrl = ApiConstant.baseUrl
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print(options.uri);
            handler.next(
              options.copyWith(headers: headers),
            );
          },
        ),
      );

    return _dio;
  }

  static ApiError handleDioError(DioException error) {
    var type = ApiErrorType.unexpected;
    var message =
        error.response?.data['error']['message'] ?? 'There is unknown error';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        type = ApiErrorType.network;
        break;
      case DioExceptionType.sendTimeout:
        type = ApiErrorType.network;
        break;
      case DioExceptionType.receiveTimeout:
        type = ApiErrorType.network;
        break;
      case DioExceptionType.unknown:
        type = ApiErrorType.unexpected;
        break;
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            type = ApiErrorType.badRequest;
            break;
          case 401:
            type = ApiErrorType.unauthorized;
            break;
          case 403:
            type = ApiErrorType.forbidden;
            break;
          case 404:
            type = ApiErrorType.notFound;
            break;
          case 409:
            type = ApiErrorType.conflict;
            break;
          case 422:
            type = ApiErrorType.badRequest;
            break;
          case 500:
            type = ApiErrorType.internalServer;
            break;
        }
        break;
      case DioExceptionType.cancel:
        type = ApiErrorType.cancelled;
        break;
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.connectionError:
        break;
    }

    return ApiError(type, message);
  }
}
