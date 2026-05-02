import '../models/category.dart';
import 'api_client.dart';

class CategoryService {
  final ApiClient _apiClient;

  CategoryService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<Category>> getList() async {
    final response = await _apiClient.dio.get('/api/lost/category/list');
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '获取分类列表失败');
    }
    return (data['data'] as List<dynamic>)
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
