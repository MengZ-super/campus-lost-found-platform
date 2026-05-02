import 'package:campus_finder/models/user.dart';
import 'package:campus_finder/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_api_client.dart';

void main() {
  late MockDio mockDio;
  late UserService userService;

  setUp(() {
    mockDio = MockDio();
    final mockApiClient = MockApiClient(mockDio);
    userService = UserService(apiClient: mockApiClient);
  });

  final sampleProfileJson = <String, dynamic>{
    'id': 1,
    'username': 'test001',
    'nickname': '测试用户',
    'phone': '13800138000',
    'email': 'test@example.com',
    'studentId': '2024001',
    'avatar': 'https://example.com/avatar.png',
    'gender': 1,
    'genderText': '男',
    'status': 1,
    'createTime': '2026-01-01 12:00:00',
    'lastLoginTime': '2026-05-01 12:00:00',
    'lastLoginIp': '127.0.0.1',
  };

  group('UserService.getProfile', () {
    test('returns UserProfile on success', () async {
      when(() => mockDio.get('/api/user/profile'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200, 'data': sampleProfileJson},
              ));

      final profile = await userService.getProfile();

      expect(profile.id, 1);
      expect(profile.username, 'test001');
      expect(profile.nickname, '测试用户');
      expect(profile.gender, 1);
      expect(profile.genderText, '男');
    });

    test('throws on server error', () async {
      when(() => mockDio.get('/api/user/profile'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 401, 'message': '未登录'},
              ));

      expect(
        () => userService.getProfile(),
        throwsA(predicate((e) => e is Exception && e.toString().contains('未登录'))),
      );
    });
  });

  group('UserService.updateProfile', () {
    test('returns updated UserProfile on success', () async {
      final updated = {...sampleProfileJson, 'nickname': '新昵称'};
      when(() => mockDio.put('/api/user/profile', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200, 'data': updated, 'message': '资料更新成功'},
              ));

      final profile = await userService.updateProfile(
        const UpdateProfileRequest(nickname: '新昵称'),
      );

      expect(profile.nickname, '新昵称');
    });

    test('throws on error', () async {
      when(() => mockDio.put('/api/user/profile', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 400, 'message': '手机号已被使用'},
              ));

      expect(
        () => userService.updateProfile(const UpdateProfileRequest(phone: '13800000000')),
        throwsA(predicate((e) => e is Exception && e.toString().contains('手机号已被使用'))),
      );
    });
  });

  group('UserService.changePassword', () {
    test('completes on success', () async {
      when(() => mockDio.put('/api/user/password', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200, 'message': '密码修改成功'},
              ));

      await expectLater(
        userService.changePassword(
          const ChangePasswordRequest(
            oldPassword: 'old',
            newPassword: 'new123',
            confirmPassword: 'new123',
          ),
        ),
        completes,
      );
    });

    test('throws on wrong old password', () async {
      when(() => mockDio.put('/api/user/password', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 400, 'message': '原密码错误'},
              ));

      expect(
        () => userService.changePassword(
          const ChangePasswordRequest(
            oldPassword: 'wrong',
            newPassword: 'new123',
            confirmPassword: 'new123',
          ),
        ),
        throwsA(predicate((e) => e is Exception && e.toString().contains('原密码错误'))),
      );
    });
  });
}
