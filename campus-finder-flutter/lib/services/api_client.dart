import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'token_storage.dart';

Dio createDio(SecureStorage storage) {
  final dio = Dio(BaseOptions(
    baseUrl: apiBaseUrl,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
    headers: {'Content-Type': 'application/json'},
  ));

  _RequestInterceptor(dio, storage);
  _ResponseInterceptor(dio, storage);

  return dio;
}

class ApiClient {
  static late final ApiClient instance;

  final Dio dio;
  final SecureStorage storage;

  const ApiClient({required this.dio, required this.storage});
}

// --- Request: inject access token ---

class _RequestInterceptor {
  _RequestInterceptor(Dio dio, SecureStorage storage) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));
  }
}

// --- Response: queue 401 refresh ---

class _ResponseInterceptor {
  static bool _isRefreshing = false;
  static final List<({RequestOptions options, ErrorInterceptorHandler handler})>
      _pendingQueue = [];

  _ResponseInterceptor(Dio dio, SecureStorage storage) {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode != 401 || error.requestOptions.path == '/api/auth/login' || error.requestOptions.path == '/api/auth/register') {
          return handler.next(error);
        }

        if (_isRefreshing) {
          _pendingQueue.add((options: error.requestOptions, handler: handler));
          return;
        }

        _isRefreshing = true;

        try {
          final refreshToken = await storage.getRefreshToken();
          if (refreshToken == null) {
            await storage.clearAll();
            return handler.next(error);
          }

          final response = await dio.post('/api/auth/refresh', data: {
            'refreshToken': refreshToken,
          });

          final data = response.data;
          if (data['code'] == 200) {
            await storage.saveTokens(
              accessToken: data['data']['accessToken'],
              refreshToken: data['data']['refreshToken'],
            );

            for (final pending in _pendingQueue) {
              pending.options.headers['Authorization'] = 'Bearer ${data['data']['accessToken']}';
              dio.fetch(pending.options).then(
                (r) => pending.handler.resolve(r),
                onError: (e) => pending.handler.next(e as DioException),
              );
            }
            _pendingQueue.clear();

            final retryResponse = await dio.fetch(error.requestOptions);
            return handler.resolve(retryResponse);
          }

          await storage.clearAll();
        } catch (e) {
          await storage.clearAll();
        } finally {
          _isRefreshing = false;
        }

        handler.next(error);
      },
    ));
  }
}
