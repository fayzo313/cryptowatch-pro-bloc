import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'error_interceptor.dart';

class ApiClient {
  final Dio dio;

  ApiClient() : dio = Dio() {
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.interceptors.add(ErrorInterceptor());
  }
}