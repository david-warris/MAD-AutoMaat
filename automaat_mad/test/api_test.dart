import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:automaat_mad/services/api_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiService apiService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiService = ApiService();
  });

  group('ApiService Tests', () {
    test('setToken sets the token correctly', () {
      const token = 'test_token_123';
      apiService.setToken(token);
      expect(apiService.token, equals(token));
    });

    test('headers includes Content-Type', () {
      final headers = apiService.headers(auth: false);
      expect(headers['Content-Type'], equals('application/json'));
    });

    test('headers includes Authorization when token is set', () {
      apiService.setToken('test_token');
      final headers = apiService.headers(auth: true);
      expect(headers['Authorization'], equals('Bearer test_token'));
    });

    test('handleResponse returns response on 200', () {
      final response = http.Response('success', 200);
      expect(() => apiService.handleResponse(response), returnsNormally);
    });

    test('handleResponse throws on 401 Unauthorized', () {
      final response = http.Response('unauthorized', 401);
      expect(
        () => apiService.handleResponse(response),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Niet ingelogd'),
        )),
      );
    });

    test('handleResponse throws on 404 Not Found', () {
      final response = http.Response('not found', 404);
      expect(
        () => apiService.handleResponse(response),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Niet gevonden'),
        )),
      );
    });

    test('handleResponse throws on 500 Server Error', () {
      final response = http.Response('server error', 500);
      expect(
        () => apiService.handleResponse(response),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Server error'),
        )),
      );
    });
  });
}