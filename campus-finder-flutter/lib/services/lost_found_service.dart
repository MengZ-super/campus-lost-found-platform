import '../models/common.dart';
import '../models/lost_found.dart';
import 'api_client.dart';

class LostFoundService {
  final ApiClient _apiClient;

  LostFoundService({required ApiClient apiClient}) : _apiClient = apiClient;

  // ── 发布管理 ──

  Future<LostFoundItem> publish(CreateLostFoundRequest request) async {
    final response =
        await _apiClient.dio.post('/api/lost/publish', data: request.toJson());
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '发布失败');
    }
    return LostFoundItem.fromJson(data['data']);
  }

  Future<LostFoundItem> update(int id, UpdateLostFoundRequest request) async {
    final response =
        await _apiClient.dio.put('/api/lost/$id', data: request.toJson());
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '更新失败');
    }
    return LostFoundItem.fromJson(data['data']);
  }

  Future<void> delete(int id) async {
    final response = await _apiClient.dio.delete('/api/lost/$id');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '删除失败');
    }
  }

  // ── 查询接口 ──

  Future<LostFoundItem> getDetail(int id) async {
    final response = await _apiClient.dio.get('/api/lost/$id');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取详情失败');
    }
    return LostFoundItem.fromJson(data['data']);
  }

  Future<PageData<LostFoundItem>> list({
    int pageNum = 1,
    int pageSize = 10,
    int? categoryId,
    String? itemType,
    String? status,
    String? campus,
    String? location,
    String? startDate,
    String? endDate,
    String? keyword,
    String? sortBy,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNum': pageNum,
      'pageSize': pageSize,
    };
    if (categoryId != null) queryParams['categoryId'] = categoryId;
    if (itemType != null) queryParams['itemType'] = itemType;
    if (status != null) queryParams['status'] = status;
    if (campus != null) queryParams['campus'] = campus;
    if (location != null) queryParams['location'] = location;
    if (startDate != null) queryParams['startDate'] = startDate;
    if (endDate != null) queryParams['endDate'] = endDate;
    if (keyword != null && keyword.isNotEmpty) queryParams['keyword'] = keyword;
    if (sortBy != null) queryParams['sortBy'] = sortBy;

    final response =
        await _apiClient.dio.get('/api/lost/list', queryParameters: queryParams);
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取列表失败');
    }
    return PageData.fromJson(
      data['data'],
      (json) => LostFoundItem.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<LostFoundItem>> search(String keyword) async {
    final response = await _apiClient.dio
        .get('/api/lost/search', queryParameters: {'keyword': keyword});
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '搜索失败');
    }
    return (data['data'] as List<dynamic>?)
            ?.map((e) => LostFoundItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  Future<List<LostFoundItem>> myList() async {
    final response = await _apiClient.dio.get('/api/lost/my');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取我的发布失败');
    }
    return (data['data'] as List<dynamic>?)
            ?.map((e) => LostFoundItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  // ── 状态流转 ──

  Future<LostFoundItem> close(int id, String reason) async {
    final response =
        await _apiClient.dio.post('/api/lost/$id/close', data: {'reason': reason});
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '关闭失败');
    }
    return LostFoundItem.fromJson(data['data']);
  }

  Future<LostFoundItem> reopen(int id) async {
    final response = await _apiClient.dio.post('/api/lost/$id/reopen');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '重新开启失败');
    }
    return LostFoundItem.fromJson(data['data']);
  }

  // ── 收藏相关 ──

  Future<void> favorite(int id) async {
    final response = await _apiClient.dio.post('/api/lost/$id/favorite');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '收藏失败');
    }
  }

  Future<void> unfavorite(int id) async {
    final response = await _apiClient.dio.delete('/api/lost/$id/favorite');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '取消收藏失败');
    }
  }

  Future<List<LostFoundItem>> favorites() async {
    final response = await _apiClient.dio.get('/api/lost/favorites');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取收藏列表失败');
    }
    return (data['data'] as List<dynamic>?)
            ?.map((e) => LostFoundItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }
}
