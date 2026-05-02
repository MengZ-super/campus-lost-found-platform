import 'package:bloc_test/bloc_test.dart';
import 'package:campus_finder/blocs/profile/profile_bloc.dart';
import 'package:campus_finder/blocs/profile/profile_event.dart';
import 'package:campus_finder/blocs/profile/profile_state.dart';
import 'package:campus_finder/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_services.dart';

void main() {
  late MockUserService mockUserService;

  const sampleProfile = UserProfile(
    id: 1,
    username: 'test001',
    nickname: '测试用户',
    phone: '13800138000',
    email: 'test@example.com',
  );

  setUp(() {
    mockUserService = MockUserService();
  });

  group('ProfileBloc', () {
    blocTest<ProfileBloc, ProfileState>(
      'LoadProfile: success path',
      build: () {
        when(() => mockUserService.getProfile()).thenAnswer((_) async => sampleProfile);
        return ProfileBloc(userService: mockUserService);
      },
      act: (bloc) => bloc.add(const ProfileEvent.loadProfile()),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.loaded(profile: sampleProfile),
      ],
      verify: (_) => verify(() => mockUserService.getProfile()).called(1),
    );

    blocTest<ProfileBloc, ProfileState>(
      'LoadProfile: error path',
      build: () {
        when(() => mockUserService.getProfile()).thenThrow(Exception('网络错误'));
        return ProfileBloc(userService: mockUserService);
      },
      act: (bloc) => bloc.add(const ProfileEvent.loadProfile()),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.error(message: 'Exception: 网络错误'),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'UpdateProfile: success path',
      build: () {
        when(() => mockUserService.updateProfile(any()))
            .thenAnswer((_) async => sampleProfile);
        return ProfileBloc(userService: mockUserService);
      },
      act: (bloc) => bloc.add(
        const ProfileEvent.updateProfile(
          request: UpdateProfileRequest(nickname: '新昵称'),
        ),
      ),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.loaded(profile: sampleProfile),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'UpdateProfile: error path',
      build: () {
        when(() => mockUserService.updateProfile(any()))
            .thenThrow(Exception('更新失败'));
        return ProfileBloc(userService: mockUserService);
      },
      act: (bloc) => bloc.add(
        const ProfileEvent.updateProfile(request: UpdateProfileRequest()),
      ),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.error(message: 'Exception: 更新失败'),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'ChangePassword: success path',
      build: () {
        when(() => mockUserService.changePassword(any()))
            .thenAnswer((_) async {});
        return ProfileBloc(userService: mockUserService);
      },
      act: (bloc) => bloc.add(
        const ProfileEvent.changePassword(
          request: ChangePasswordRequest(
            oldPassword: 'old',
            newPassword: 'new123',
            confirmPassword: 'new123',
          ),
        ),
      ),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.passwordChanged(),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'ChangePassword: error path',
      build: () {
        when(() => mockUserService.changePassword(any()))
            .thenThrow(Exception('原密码错误'));
        return ProfileBloc(userService: mockUserService);
      },
      act: (bloc) => bloc.add(
        const ProfileEvent.changePassword(
          request: ChangePasswordRequest(
            oldPassword: 'wrong',
            newPassword: 'new123',
            confirmPassword: 'new123',
          ),
        ),
      ),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.error(message: 'Exception: 原密码错误'),
      ],
    );

    test('initial state is ProfileInitial', () {
      final bloc = ProfileBloc(userService: mockUserService);
      expect(bloc.state, const ProfileState.initial());
    });
  });
}
