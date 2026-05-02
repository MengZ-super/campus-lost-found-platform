import 'package:dio/dio.dart';
import 'api_client.dart';

class UploadService {
  final ApiClient _apiClient;

  UploadService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<String> upload(String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    final response = await _apiClient.dio.post('/api/upload', data: formData);
    final data = response.data;
    if (data['code'] != 200) {
      throw Exception(data['message'] ?? '上传失败');
    }
    return data['data'] as String;
  }
}
