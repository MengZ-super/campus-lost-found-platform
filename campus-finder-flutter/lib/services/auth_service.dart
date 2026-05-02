import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<AuthResponse> login(String username, String password) async {
    final response = await _apiClient.dio.post('/api/auth/login', data: {
      'username': username,
      'password': password,
    });
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '登录失败');
    }
    return AuthResponse.fromJson(data['data']);
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    final response =
        await _apiClient.dio.post('/api/auth/register', data: request.toJson());
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '注册失败');
    }
    return AuthResponse.fromJson(data['data']);
  }

  Future<User> me() async {
    final response = await _apiClient.dio.get('/api/auth/me');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取用户信息失败');
    }
    return User.fromJson(data['data']);
  }

  Future<void> logout() async {
    await _apiClient.dio.post('/api/auth/logout');
  }

  Future<AuthResponse> refresh(String refreshToken) async {
    final response = await _apiClient.dio.post('/api/auth/refresh', data: {
      'refreshToken': refreshToken,
    });
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '刷新令牌失败');
    }
    return AuthResponse.fromJson(data['data']);
  }
}
