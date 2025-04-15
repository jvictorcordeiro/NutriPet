import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../errors/network_exceptions.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class ApiClient {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  ApiClient() : dio = Dio(), secureStorage = FlutterSecureStorage() {

    // Configurações base do Dio
    dio.options.baseUrl = 'http://localhost:8000/api';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    // Adiciona interceptors
    dio.interceptors.addAll([
      AuthInterceptor(secureStorage),
      LoggingInterceptor(),
    ]);
  }

  Future<Response> get(String path) async {
    try {
      return await dio.get(path);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }
}