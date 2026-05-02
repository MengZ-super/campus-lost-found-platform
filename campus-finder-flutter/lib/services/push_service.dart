import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:jpush_flutter/jpush_interface.dart';
import '../config/push_config.dart';

class PushService {
  final JPushFlutterInterface _jpush = JPush.newJPush();
  final GlobalKey<NavigatorState> navigatorKey;

  PushService({required this.navigatorKey});

  Future<void> init() async {
    _jpush.setup(
      appKey: jpushAppKey,
      channel: jpushChannel,
      production: false,
      debug: true,
    );

    _jpush.applyPushAuthority(
      const NotificationSettingsIOS(
        sound: true,
        alert: true,
        badge: true,
      ),
    );

    _jpush.addEventHandler(
      onReceiveNotification: (Map<String, dynamic> message) async {
        // 前台收到通知时系统自动展示横幅，此处不做额外处理
      },
      onOpenNotification: (Map<String, dynamic> message) async {
        _handleNotificationOpen(message);
      },
    );
  }

  void _handleNotificationOpen(Map<String, dynamic> message) {
    final extras = message['extras'] as Map<String, dynamic>?;
    if (extras == null) return;

    final page = extras['page'] as String?;
    if (page == null || navigatorKey.currentContext == null) return;

    final router = GoRouter.of(navigatorKey.currentContext!);
    router.go(_mapPageToRoute(page));
  }

  String _mapPageToRoute(String page) {
    if (page.startsWith('/')) return page;

    final parts = page.split('?');
    final name = parts[0];
    final query = parts.length > 1 ? parts[1] : '';

    switch (name) {
      case 'detail':
        final id = Uri.splitQueryString(query)['id'] ?? '';
        return '/lost-found/$id';
      case 'my_publishes':
        return '/my/publishes';
      case 'my_claims':
        return '/my/claims';
      case 'home':
        return '/home';
      case 'lost_found':
        return '/lost-found';
      case 'profile':
        return '/my';
      default:
        return '/home';
    }
  }

  Future<String?> getRegistrationId() async {
    try {
      return await _jpush.getRegistrationID();
    } catch (_) {
      return null;
    }
  }

  Future<void> setAlias(String alias) async {
    try {
      await _jpush.setAlias(alias);
    } catch (_) {
      // 别名设置失败不影响主流程
    }
  }

  Future<void> deleteAlias() async {
    try {
      await _jpush.deleteAlias();
    } catch (_) {}
  }
}
