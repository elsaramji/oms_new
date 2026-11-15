import 'package:dio/dio.dart';
import 'package:oms_new/core/error/exceptions.dart';

typedef TokenProvider = Future<String?> Function();

class AuthInterceptor extends QueuedInterceptor {
  final TokenProvider? tokenProvider;

  AuthInterceptor({this.tokenProvider});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (tokenProvider != null) {
      final token = await tokenProvider!();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }
}

class ErrorMappingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'Unexpected network error occurred';
    int? statusCode = err.response?.statusCode;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Network connection timed out';
        break;
      case DioExceptionType.badResponse:
        final data = err.response?.data;
        if (data is Map && data.containsKey('message')) {
          errorMessage = data['message'].toString();
        } else if (statusCode != null) {
          errorMessage = 'Server error with status code $statusCode';
        }
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No active internet connection';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled';
        break;
      default:
        errorMessage = err.message ?? 'Unknown network error';
    }

    final mappedException = ServerException(errorMessage, statusCode);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: mappedException,
        message: errorMessage,
      ),
    );
  }
}

Dio createDioClient({
  String baseUrl = 'https://api.oms-clinic.local/v1',
  TokenProvider? tokenProvider,
  List<Interceptor>? additionalInterceptors,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(tokenProvider: tokenProvider),
    ErrorMappingInterceptor(),
    if (additionalInterceptors != null) ...additionalInterceptors,
  ]);

  return dio;
}
