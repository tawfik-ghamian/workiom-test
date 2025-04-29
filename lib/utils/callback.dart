import 'package:dio/dio.dart';

import 'api_error.dart';
import 'dio_client.dart';

Future<T> callEndpoint<T>(Future<T> Function() callback) async {
  try {
    return await callback();
  } on DioException catch (err) {
    throw DioClient.handleDioError(err);
  } catch (err) {
    throw ApiError(ApiErrorType.unexpected, "There is unknown error");
  }
}
