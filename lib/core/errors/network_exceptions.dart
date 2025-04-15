// lib/core/network/exceptions/network_exceptions.dart
import 'package:dio/dio.dart';

class NetworkExceptions implements Exception {
  final String message;

  NetworkExceptions(this.message);

  factory NetworkExceptions.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkExceptions('Tempo de conexão esgotado');
      case DioExceptionType.sendTimeout:
        return NetworkExceptions('Tempo de envio esgotado');
      case DioExceptionType.receiveTimeout:
        return NetworkExceptions('Tempo de recebimento esgotado');
      case DioExceptionType.badResponse:
        return NetworkExceptions('Resposta inválida: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return NetworkExceptions('Requisição cancelada');
      default:
        return NetworkExceptions('Erro de rede: ${error.message}');
    }
  }

  @override
  String toString() => message;
}