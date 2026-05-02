import 'package:campus_finder/models/common.dart';
import 'package:campus_finder/models/lost_found.dart';
import 'package:campus_finder/services/api_client.dart';
import 'package:campus_finder/services/lost_found_service.dart';
import 'package:campus_finder/services/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late LostFoundService service;
  late MockDio mockDio;
  late MockSecureStorage mockStorage;
  late ApiClient apiClient;

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockSecureStorage();
    apiClient = ApiClient(dio: mockDio, storage: mockStorage);
    service = LostFoundService(apiClient: apiClient);
    registerFallbackValue(RequestOptions(path: ''));
  });

  // ── publish ──

  group('publish', () {
    final request = CreateLostFoundRequest(
      categoryId: 1,
      itemType: 'lost',
      title: 'Lost Wallet',
      description: 'Brown wallet',
      location: 'Library',
      happenedTime: DateTime(2026, 1, 1, 10, 0),
    );
    final responseJson = {
      'code': 200,
      'message': 'success',
      'data': {
        'id': 1,
        'userId': 1,
        'categoryId': 1,
        'itemType': 'lost',
        'title': 'Lost Wallet',
        'description': 'Brown wallet',
        'location': 'Library',
        'happenedTime': '2026-01-01 10:00:00',
        'status': 'pending',
      },
    };

    test('should return LostFoundItem on success', () async {
      when(() => mockDio.post('/api/lost/publish', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: responseJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.publish(request);
      expect(result, isA<LostFoundItem>());
      expect(result.id, 1);
      expect(result.title, 'Lost Wallet');
    });

    test('should throw on non-200 code', () async {
      when(() => mockDio.post('/api/lost/publish', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: {'code': 500, 'message': 'Server error'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.publish(request), throwsException);
    });
  });

  // ── update ──

  group('update', () {
    final request = UpdateLostFoundRequest(title: 'Updated Title');
    final responseJson = {
      'code': 200,
      'message': 'success',
      'data': {
        'id': 1,
        'userId': 1,
        'categoryId': 1,
        'itemType': 'lost',
        'title': 'Updated Title',
        'description': 'Brown wallet',
        'location': 'Library',
        'status': 'pending',
      },
    };

    test('should return updated LostFoundItem on success', () async {
      when(() => mockDio.put('/api/lost/1', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: responseJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.update(1, request);
      expect(result, isA<LostFoundItem>());
      expect(result.title, 'Updated Title');
    });

    test('should throw on failure', () async {
      when(() => mockDio.put('/api/lost/1', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: {'code': 403, 'message': 'Not owner'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.update(1, request), throwsException);
    });
  });

  // ── delete ──

  group('delete', () {
    test('should complete without error on success', () async {
      when(() => mockDio.delete('/api/lost/1'))
          .thenAnswer((_) async => Response(
                data: {'code': 200, 'message': 'success'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      await service.delete(1);
    });

    test('should throw on failure', () async {
      when(() => mockDio.delete('/api/lost/1'))
          .thenAnswer((_) async => Response(
                data: {'code': 403, 'message': 'Not owner'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.delete(1), throwsException);
    });
  });

  // ── getDetail ──

  group('getDetail', () {
    final responseJson = {
      'code': 200,
      'message': 'success',
      'data': {
        'id': 1,
        'userId': 1,
        'categoryId': 1,
        'itemType': 'lost',
        'title': 'Lost Wallet',
        'description': 'Brown wallet',
        'location': 'Library',
        'status': 'pending',
        'viewCount': 5,
        'favoriteCount': 2,
        'claimCount': 1,
      },
    };

    test('should return LostFoundItem on success', () async {
      when(() => mockDio.get('/api/lost/1'))
          .thenAnswer((_) async => Response(
                data: responseJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.getDetail(1);
      expect(result, isA<LostFoundItem>());
      expect(result.id, 1);
      expect(result.viewCount, 5);
    });

    test('should throw on failure', () async {
      when(() => mockDio.get('/api/lost/1'))
          .thenAnswer((_) async => Response(
                data: {'code': 404, 'message': 'Not found'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.getDetail(1), throwsException);
    });
  });

  // ── list ──

  group('list', () {
    final pageJson = {
      'code': 200,
      'message': 'success',
      'data': {
        'current': 1,
        'size': 10,
        'total': 2,
        'pages': 1,
        'records': [
          {
            'id': 1,
            'userId': 1,
            'categoryId': 1,
            'itemType': 'lost',
            'title': 'Item 1',
            'description': 'Desc 1',
            'location': 'Library',
            'status': 'pending',
          },
          {
            'id': 2,
            'userId': 2,
            'categoryId': 2,
            'itemType': 'found',
            'title': 'Item 2',
            'description': 'Desc 2',
            'location': 'Canteen',
            'status': 'pending',
          },
        ],
      },
    };

    test('should return PageData on success with default params', () async {
      when(() => mockDio.get('/api/lost/list', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: pageJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.list();
      expect(result, isA<PageData<LostFoundItem>>());
      expect(result.current, 1);
      expect(result.total, 2);
      expect(result.records.length, 2);
    });

    test('should include all query params when provided', () async {
      when(() => mockDio.get('/api/lost/list', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: pageJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      await service.list(
        pageNum: 2,
        pageSize: 20,
        categoryId: 1,
        itemType: 'lost',
        status: 'pending',
        campus: 'Main Campus',
        keyword: 'wallet',
        sortBy: 'newest',
      );

      final captured = verify(
        () => mockDio.get(
          '/api/lost/list',
          queryParameters: captureAny(named: 'queryParameters'),
        ),
      ).captured.single as Map<String, dynamic>;
      expect(captured['pageNum'], 2);
      expect(captured['pageSize'], 20);
      expect(captured['categoryId'], 1);
      expect(captured['itemType'], 'lost');
      expect(captured['keyword'], 'wallet');
      expect(captured['sortBy'], 'newest');
    });

    test('should omit null/empty params from query', () async {
      when(() => mockDio.get('/api/lost/list', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: pageJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      await service.list();

      final captured = verify(
        () => mockDio.get(
          '/api/lost/list',
          queryParameters: captureAny(named: 'queryParameters'),
        ),
      ).captured.single as Map<String, dynamic>;
      expect(captured.containsKey('categoryId'), false);
      expect(captured.containsKey('keyword'), false);
    });

    test('should throw on failure', () async {
      when(() => mockDio.get('/api/lost/list', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: {'code': 500, 'message': 'Server error'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.list(), throwsException);
    });
  });

  // ── search ──

  group('search', () {
    final searchJson = {
      'code': 200,
      'message': 'success',
      'data': [
        {
          'id': 1,
          'userId': 1,
          'categoryId': 1,
          'itemType': 'lost',
          'title': 'Wallet',
          'description': 'Brown wallet',
          'location': 'Library',
          'status': 'pending',
        },
      ],
    };

    test('should return list of LostFoundItem on success', () async {
      when(() => mockDio.get('/api/lost/search', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: searchJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.search('wallet');
      expect(result, isA<List<LostFoundItem>>());
      expect(result.length, 1);
      expect(result.first.title, 'Wallet');
    });

    test('should return empty list when data is null', () async {
      when(() => mockDio.get('/api/lost/search', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: {'code': 200, 'message': 'success', 'data': null},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.search('nothing');
      expect(result, isEmpty);
    });

    test('should throw on failure', () async {
      when(() => mockDio.get('/api/lost/search', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: {'code': 500, 'message': 'Server error'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.search('x'), throwsException);
    });
  });

  // ── myList ──

  group('myList', () {
    final myListJson = {
      'code': 200,
      'message': 'success',
      'data': [
        {
          'id': 1,
          'userId': 1,
          'categoryId': 1,
          'itemType': 'lost',
          'title': 'My Item',
          'description': 'My desc',
          'location': 'Library',
          'status': 'pending',
        },
      ],
    };

    test('should return list of user items on success', () async {
      when(() => mockDio.get('/api/lost/my'))
          .thenAnswer((_) async => Response(
                data: myListJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.myList();
      expect(result, isA<List<LostFoundItem>>());
      expect(result.length, 1);
    });

    test('should return empty list when data is null', () async {
      when(() => mockDio.get('/api/lost/my'))
          .thenAnswer((_) async => Response(
                data: {'code': 200, 'message': 'success', 'data': null},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.myList();
      expect(result, isEmpty);
    });

    test('should throw on failure', () async {
      when(() => mockDio.get('/api/lost/my'))
          .thenAnswer((_) async => Response(
                data: {'code': 401, 'message': 'Unauthorized'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.myList(), throwsException);
    });
  });

  // ── close ──

  group('close', () {
    test('should return updated LostFoundItem on success', () async {
      when(() => mockDio.post('/api/lost/1/close', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: {
                  'code': 200,
                  'message': 'success',
                  'data': {
                    'id': 1,
                    'userId': 1,
                    'categoryId': 1,
                    'itemType': 'lost',
                    'title': 'Item',
                    'description': 'Desc',
                    'location': 'Library',
                    'status': 'closed',
                    'closeReason': 'Found it',
                  },
                },
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.close(1, 'Found it');
      expect(result.status, 'closed');
      expect(result.closeReason, 'Found it');
    });

    test('should throw on failure', () async {
      when(() => mockDio.post('/api/lost/1/close', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: {'code': 403, 'message': 'Not owner'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.close(1, 'reason'), throwsException);
    });
  });

  // ── reopen ──

  group('reopen', () {
    test('should return reopened LostFoundItem on success', () async {
      when(() => mockDio.post('/api/lost/1/reopen'))
          .thenAnswer((_) async => Response(
                data: {
                  'code': 200,
                  'message': 'success',
                  'data': {
                    'id': 1,
                    'userId': 1,
                    'categoryId': 1,
                    'itemType': 'lost',
                    'title': 'Item',
                    'description': 'Desc',
                    'location': 'Library',
                    'status': 'pending',
                  },
                },
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.reopen(1);
      expect(result.status, 'pending');
    });

    test('should throw on failure', () async {
      when(() => mockDio.post('/api/lost/1/reopen'))
          .thenAnswer((_) async => Response(
                data: {'code': 403, 'message': 'Not owner'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.reopen(1), throwsException);
    });
  });

  // ── favorite ──

  group('favorite', () {
    test('should complete without error on success', () async {
      when(() => mockDio.post('/api/lost/1/favorite'))
          .thenAnswer((_) async => Response(
                data: {'code': 200, 'message': 'success'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      await service.favorite(1);
    });

    test('should throw on failure', () async {
      when(() => mockDio.post('/api/lost/1/favorite'))
          .thenAnswer((_) async => Response(
                data: {'code': 400, 'message': 'Already favorited'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.favorite(1), throwsException);
    });
  });

  // ── unfavorite ──

  group('unfavorite', () {
    test('should complete without error on success', () async {
      when(() => mockDio.delete('/api/lost/1/favorite'))
          .thenAnswer((_) async => Response(
                data: {'code': 200, 'message': 'success'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      await service.unfavorite(1);
    });

    test('should throw on failure', () async {
      when(() => mockDio.delete('/api/lost/1/favorite'))
          .thenAnswer((_) async => Response(
                data: {'code': 400, 'message': 'Not favorited'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.unfavorite(1), throwsException);
    });
  });

  // ── favorites ──

  group('favorites', () {
    final favoritesJson = {
      'code': 200,
      'message': 'success',
      'data': [
        {
          'id': 1,
          'userId': 1,
          'categoryId': 1,
          'itemType': 'lost',
          'title': 'Fav Item',
          'description': 'Fav desc',
          'location': 'Library',
          'status': 'pending',
        },
      ],
    };

    test('should return list of favorites on success', () async {
      when(() => mockDio.get('/api/lost/favorites'))
          .thenAnswer((_) async => Response(
                data: favoritesJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.favorites();
      expect(result, isA<List<LostFoundItem>>());
      expect(result.length, 1);
    });

    test('should return empty list when data is null', () async {
      when(() => mockDio.get('/api/lost/favorites'))
          .thenAnswer((_) async => Response(
                data: {'code': 200, 'message': 'success', 'data': null},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await service.favorites();
      expect(result, isEmpty);
    });

    test('should throw on failure', () async {
      when(() => mockDio.get('/api/lost/favorites'))
          .thenAnswer((_) async => Response(
                data: {'code': 500, 'message': 'Server error'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(() => service.favorites(), throwsException);
    });
  });
}
