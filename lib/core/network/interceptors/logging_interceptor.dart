import 'package:dio/dio.dart';
import 'package:logging/logging.dart';


class LoggingInterceptor extends Interceptor {
  final _logger = Logger('ApiClient');
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.fine('Requisição enviada: ${options.method} ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.fine('Resposta recebida: ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.severe('Erro na requisição: ${err.message}');
    super.onError(err, handler);
  }
}