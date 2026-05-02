import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app.dart';
import 'config/router.dart';
import 'services/api_client.dart';
import 'services/push_service.dart';
import 'services/token_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const storage = SecureStorage(
    secureStorage: FlutterSecureStorage(),
  );

  final dio = createDio(storage);
  final apiClient = ApiClient(dio: dio, storage: storage);
  ApiClient.instance = apiClient;

  final pushService = PushService(navigatorKey: rootNavigatorKey);
  await pushService.init();

  runApp(CampusFinderApp(
    storage: storage,
    apiClient: apiClient,
    pushService: pushService,
  ));
}
