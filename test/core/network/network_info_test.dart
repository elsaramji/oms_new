import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/core/network/dio_client.dart';
import 'package:oms_new/core/network/network_info.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('NetworkInfoImpl', () {
    test('returns true when connected via WiFi or mobile data', () async {
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      final result = await networkInfo.isConnected;

      expect(result, isTrue);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });

    test('returns false when connectivity result is none', () async {
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await networkInfo.isConnected;

      expect(result, isFalse);
    });

    test('returns false when connectivity result list is empty', () async {
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => []);

      final result = await networkInfo.isConnected;

      expect(result, isFalse);
    });

    test('maps onConnectivityChanged stream to boolean emissions', () async {
      final controller = StreamController<List<ConnectivityResult>>();
      when(() => mockConnectivity.onConnectivityChanged)
          .thenAnswer((_) => controller.stream);

      final emissions = <bool>[];
      final subscription = networkInfo.onConnectivityChanged.listen(emissions.add);

      controller.add([ConnectivityResult.mobile]);
      controller.add([ConnectivityResult.none]);
      controller.add([ConnectivityResult.ethernet]);

      await pumpEventQueue();

      expect(emissions, equals([true, false, true]));

      await subscription.cancel();
      await controller.close();
    });
  });

  group('AuthInterceptor', () {
    test('injects Bearer token when token is provided', () async {
      final interceptor = AuthInterceptor(tokenProvider: () async => 'jwt_token_123');
      final options = RequestOptions(path: '/test');
      final handler = RequestInterceptorHandler();

      var handled = false;
      interceptor.onRequest(options, RequestInterceptorHandlerWrapper((opt) {
        handled = true;
        expect(opt.headers['Authorization'], equals('Bearer jwt_token_123'));
      }));

      await pumpEventQueue();
      expect(handled, isTrue);
    });

    test('does not add Authorization header when token is null', () async {
      final interceptor = AuthInterceptor(tokenProvider: () async => null);
      final options = RequestOptions(path: '/test');

      var handled = false;
      interceptor.onRequest(options, RequestInterceptorHandlerWrapper((opt) {
        handled = true;
        expect(opt.headers.containsKey('Authorization'), isFalse);
      }));

      await pumpEventQueue();
      expect(handled, isTrue);
    });
  });

  group('ErrorMappingInterceptor', () {
    test('maps connection timeout to ServerException', () {
      final interceptor = ErrorMappingInterceptor();
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      final handler = ErrorInterceptorHandlerWrapper((rejectedErr) {
        expect(rejectedErr.error, isA<ServerException>());
        final serverErr = rejectedErr.error as ServerException;
        expect(serverErr.message, equals('Network connection timed out'));
      });

      interceptor.onError(dioException, handler);
    });

    test('maps badResponse with JSON error message to ServerException', () {
      final interceptor = ErrorMappingInterceptor();
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
          data: {'message': 'Patient record not found'},
        ),
      );

      final handler = ErrorInterceptorHandlerWrapper((rejectedErr) {
        expect(rejectedErr.error, isA<ServerException>());
        final serverErr = rejectedErr.error as ServerException;
        expect(serverErr.message, equals('Patient record not found'));
        expect(serverErr.statusCode, equals(404));
      });

      interceptor.onError(dioException, handler);
    });
  });
}

class RequestInterceptorHandlerWrapper extends RequestInterceptorHandler {
  final void Function(RequestOptions) onNext;

  RequestInterceptorHandlerWrapper(this.onNext);

  @override
  void next(RequestOptions requestOptions) {
    onNext(requestOptions);
  }
}

class ErrorInterceptorHandlerWrapper extends ErrorInterceptorHandler {
  final void Function(DioException) onReject;

  ErrorInterceptorHandlerWrapper(this.onReject);

  @override
  void reject(DioException error, [bool? callHandler]) {
    onReject(error);
  }
}
