import 'package:dio/dio.dart';
import '../errors/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = "An unexpected error occurred.";
    
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = "Connection timeout with server.";
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 429) {
          errorMessage = "Rate limit hit. Try again shortly.";
        } else if (statusCode != null && statusCode >= 500) {
          errorMessage = "Server error. Please try later.";
        }
        break;
      default:
        errorMessage = "Network connection failed.";
    }
    
    return handler.next(DioException(
      requestOptions: err.requestOptions,
      error: ServerException(errorMessage),
    ));
  }
}