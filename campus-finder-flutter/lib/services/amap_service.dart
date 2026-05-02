import 'package:dio/dio.dart';
import '../config/amap_config.dart';

/// 高德地图 REST API 服务
///
/// 封装 POI 搜索、逆地理编码等 Web 服务接口。
class AmapService {
  final Dio _dio;

  AmapService() : _dio = Dio(BaseOptions(
    baseUrl: AmapConfig.restBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// 关键词搜索 POI
  ///
  /// [keyword] 搜索关键词
  /// [city] 城市名称或 adcode，为空则全国搜索
  /// [page] 页码
  /// [offset] 每页条数
  Future<List<AmapPoi>> searchPoi({
    required String keyword,
    String? city,
    int page = 1,
    int offset = 20,
  }) async {
    final params = <String, dynamic>{
      'key': AmapConfig.webApiKey,
      'keywords': keyword,
      'page': page,
      'offset': offset,
    };
    if (city != null && city.isNotEmpty) {
      params['city'] = city;
    }

    final response = await _dio.get('/place/text', queryParameters: params);
    final data = response.data;

    if (data['status'] != '1') {
      throw AmapException(data['info'] ?? '搜索失败');
    }

    final pois = data['pois'] as List? ?? [];
    return pois.map((p) => AmapPoi.fromJson(p)).toList();
  }

  /// 输入提示（搜索建议）
  ///
  /// 用于搜索框自动补全。
  Future<List<AmapTip>> inputTips({
    required String keywords,
    String? city,
  }) async {
    final params = <String, dynamic>{
      'key': AmapConfig.webApiKey,
      'keywords': keywords,
    };
    if (city != null && city.isNotEmpty) {
      params['city'] = city;
    }

    final response = await _dio.get('/assistant/inputtips', queryParameters: params);
    final data = response.data;

    if (data['status'] != '1') {
      return [];
    }

    final tips = data['tips'] as List? ?? [];
    return tips
        .where((t) => t['location'] != null && t['location'].toString().isNotEmpty)
        .map((t) => AmapTip.fromJson(t))
        .toList();
  }

  /// 逆地理编码（坐标 → 地址）
  ///
  /// [latitude] 纬度
  /// [longitude] 经度
  Future<AmapRegeoResult> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    final response = await _dio.get('/geocode/regeo', queryParameters: {
      'key': AmapConfig.webApiKey,
      'location': '$longitude,$latitude',
      'extensions': 'base',
    });
    final data = response.data;

    if (data['status'] != '1') {
      throw AmapException(data['info'] ?? '逆地理编码失败');
    }

    final regeo = data['regeocode'];
    return AmapRegeoResult(
      address: regeo['formatted_address'] ?? '',
      adcode: regeo['addressComponent']?['adcode'] ?? '',
    );
  }
}

/// POI 搜索结果
class AmapPoi {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  const AmapPoi({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory AmapPoi.fromJson(Map<String, dynamic> json) {
    final location = (json['location'] as String?)?.split(',') ?? ['0', '0'];
    return AmapPoi(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      longitude: double.tryParse(location[0]) ?? 0,
      latitude: double.tryParse(location[1]) ?? 0,
    );
  }
}

/// 输入提示结果
class AmapTip {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  const AmapTip({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory AmapTip.fromJson(Map<String, dynamic> json) {
    final location = (json['location'] as String?)?.split(',') ?? ['0', '0'];
    return AmapTip(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      longitude: double.tryParse(location[0]) ?? 0,
      latitude: double.tryParse(location[1]) ?? 0,
    );
  }
}

/// 逆地理编码结果
class AmapRegeoResult {
  final String address;
  final String adcode;

  const AmapRegeoResult({required this.address, required this.adcode});
}

/// 高德 API 异常
class AmapException implements Exception {
  final String message;
  const AmapException(this.message);

  @override
  String toString() => 'AmapException: $message';
}
