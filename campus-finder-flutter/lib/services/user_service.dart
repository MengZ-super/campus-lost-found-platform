import '../models/user.dart';
import 'api_client.dart';

class UserService {
  final ApiClient _apiClient;

  UserService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<UserProfile> getProfile() async {
    final response = await _apiClient.dio.get('/api/user/profile');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取个人资料失败');
    }
    return UserProfile.fromJson(data['data']);
  }

  Future<UserProfile> updateProfile(UpdateProfileRequest request) async {
    final response =
        await _apiClient.dio.put('/api/user/profile', data: request.toJson());
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '更新个人资料失败');
    }
    return UserProfile.fromJson(data['data']);
  }

  Future<void> changePassword(ChangePasswordRequest request) async {
    final response =
        await _apiClient.dio.put('/api/user/password', data: request.toJson());
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '修改密码失败');
    }
  }
}
