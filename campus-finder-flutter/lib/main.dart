import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app.dart';
import 'services/api_client.dart';
import 'services/token_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = SecureStorage(
    secureStorage: const FlutterSecureStorage(),
  );

  final dio = createDio(storage);
  final apiClient = ApiClient(dio: dio, storage: storage);

  runApp(CampusFinderApp(
    storage: storage,
    apiClient: apiClient,
  ));
}
