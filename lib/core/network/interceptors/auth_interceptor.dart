import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {

  final List<String> publicEndpoints = [
    '/login',
    '/register',
    '/public-data',
  ];

  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  AuthInterceptor(this.secureStorage);


  Future<String?> _getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    try{
    // Verifica se o endpoint atual está na lista de endpoints públicos
    if (!publicEndpoints.contains(options.path)) {

      final token =  await _getAccessToken();
      if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        } else {
          // Se o token não estiver disponível, lança uma exceção
          throw DioException(
            requestOptions: options,
            error: 'Token de autenticação não encontrado',
        );
      }
    }
    handler.next(options);
    } catch (e) {
      handler.reject(DioException(requestOptions: options, error: e));
    }

    super.onRequest(options, handler);
  }
}