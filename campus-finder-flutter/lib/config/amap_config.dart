/// 高德地图配置
///
/// Android 和 iOS 使用不同的 Key。
/// 请在 https://console.amap.com 申请对应平台 Key 后填入。
class AmapConfig {
  AmapConfig._();

  /// Android 平台 Key（发布前替换）
  static const String androidKey = 'YOUR_ANDROID_AMAP_KEY';

  /// iOS 平台 Key（发布前替换）
  static const String iosKey = 'YOUR_IOS_AMAP_KEY';

  /// Web服务 API Key（用于 REST API 搜索/逆地理编码）
  static const String webApiKey = 'YOUR_WEB_API_AMAP_KEY';

  /// REST API 基础地址
  static const String restBaseUrl = 'https://restapi.amap.com/v3';

  /// 默认地图中心（校园坐标，需根据实际校区调整）
  static const double defaultLat = 39.904989;
  static const double defaultLng = 116.405285;

  /// 默认缩放级别
  static const double defaultZoom = 15;
}
