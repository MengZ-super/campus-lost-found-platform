import 'package:campus_finder/services/api_client.dart';
import 'package:campus_finder/services/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockApiClient extends ApiClient {
  MockApiClient(MockDio mockDio)
      : super(dio: mockDio, storage: _MockStorage());
}

class _MockStorage extends Mock implements SecureStorage {}
