import '../models/claim.dart';
import 'api_client.dart';

class ClaimService {
  final ApiClient _apiClient;

  ClaimService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Claim> apply(CreateClaimRequest request) async {
    final response =
        await _apiClient.dio.post('/api/lost/claim/apply', data: request.toJson());
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '提交申请失败');
    }
    return Claim.fromJson(data['data']);
  }

  Future<void> cancel(int id) async {
    final response = await _apiClient.dio.post('/api/lost/claim/$id/cancel');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '取消申请失败');
    }
  }

  Future<Claim> detail(int id) async {
    final response = await _apiClient.dio.get('/api/lost/claim/$id');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取申请详情失败');
    }
    return Claim.fromJson(data['data']);
  }

  Future<List<Claim>> myList() async {
    final response = await _apiClient.dio.get('/api/lost/claim/my');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取我的申请失败');
    }
    return (data['data'] as List<dynamic>)
        .map((e) => Claim.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Claim>> listByLostFound(int lostFoundId) async {
    final response =
        await _apiClient.dio.get('/api/lost/claim/lost-found/$lostFoundId');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取申请列表失败');
    }
    return (data['data'] as List<dynamic>)
        .map((e) => Claim.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Claim> review(int id, ReviewClaimRequest request) async {
    final response = await _apiClient.dio.post(
      '/api/lost/claim/$id/review',
      data: request.toJson(),
    );
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '审核失败');
    }
    return Claim.fromJson(data['data']);
  }
}
