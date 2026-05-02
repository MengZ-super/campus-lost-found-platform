import 'package:campus_finder/models/claim.dart';
import 'package:campus_finder/services/claim_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_api_client.dart';

void main() {
  late MockDio mockDio;
  late ClaimService claimService;

  setUp(() {
    mockDio = MockDio();
    final mockApiClient = MockApiClient(mockDio);
    claimService = ClaimService(apiClient: mockApiClient);
  });

  final sampleClaimJson = <String, dynamic>{
    'id': 1,
    'lostFoundId': 10,
    'userId': 100,
    'claimType': 'found',
    'description': '这是我的物品，特征如下...',
    'features': '黑色钱包，内有学生证',
    'contact': '13800138000',
    'proofImages': ['img1.jpg'],
    'status': 'pending',
    'statusText': '待审核',
    'createTime': '2026-05-01 12:00:00',
  };

  group('ClaimService.apply', () {
    test('returns Claim on success', () async {
      when(() => mockDio.post('/api/lost/claim/apply', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200, 'data': sampleClaimJson},
              ));

      final result = await claimService.apply(
        const CreateClaimRequest(
          lostFoundId: 10,
          claimType: 'found',
          description: '描述',
          contact: '13800138000',
        ),
      );

      expect(result.id, 1);
      expect(result.status, 'pending');
    });

    test('throws on server error', () async {
      when(() => mockDio.post('/api/lost/claim/apply', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 400, 'message': '物品不存在'},
              ));

      expect(
        () => claimService.apply(
          const CreateClaimRequest(
            lostFoundId: 99,
            claimType: 'found',
            description: 'test',
            contact: '13800138000',
          ),
        ),
        throwsA(predicate((e) => e is Exception && e.toString().contains('物品不存在'))),
      );
    });
  });

  group('ClaimService.cancel', () {
    test('completes on success', () async {
      when(() => mockDio.post('/api/lost/claim/1/cancel'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200},
              ));

      await expectLater(claimService.cancel(1), completes);
    });

    test('throws on error', () async {
      when(() => mockDio.post('/api/lost/claim/1/cancel'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 400, 'message': '申请不存在'},
              ));

      expect(
        () => claimService.cancel(1),
        throwsA(predicate((e) => e is Exception && e.toString().contains('申请不存在'))),
      );
    });
  });

  group('ClaimService.detail', () {
    test('returns Claim on success', () async {
      when(() => mockDio.get('/api/lost/claim/1'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200, 'data': sampleClaimJson},
              ));

      final result = await claimService.detail(1);
      expect(result.id, 1);
    });
  });

  group('ClaimService.myList', () {
    test('returns list on success', () async {
      when(() => mockDio.get('/api/lost/claim/my'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {
                  'code': 200,
                  'data': [sampleClaimJson, sampleClaimJson],
                },
              ));

      final result = await claimService.myList();
      expect(result.length, 2);
    });

    test('returns empty list', () async {
      when(() => mockDio.get('/api/lost/claim/my'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200, 'data': []},
              ));

      final result = await claimService.myList();
      expect(result, isEmpty);
    });
  });

  group('ClaimService.listByLostFound', () {
    test('returns list on success', () async {
      when(() => mockDio.get('/api/lost/claim/lost-found/10'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {
                  'code': 200,
                  'data': [sampleClaimJson],
                },
              ));

      final result = await claimService.listByLostFound(10);
      expect(result.length, 1);
    });
  });

  group('ClaimService.review', () {
    test('approve returns updated Claim', () async {
      final approved = {...sampleClaimJson, 'status': 'approved', 'statusText': '已通过'};
      when(() => mockDio.post('/api/lost/claim/1/review', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200, 'data': approved},
              ));

      final result = await claimService.review(
        1,
        const ReviewClaimRequest(action: 'approve'),
      );
      expect(result.status, 'approved');
    });

    test('reject returns updated Claim', () async {
      final rejected = {...sampleClaimJson, 'status': 'rejected', 'statusText': '已拒绝'};
      when(() => mockDio.post('/api/lost/claim/1/review', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: {'code': 200, 'data': rejected},
              ));

      final result = await claimService.review(
        1,
        const ReviewClaimRequest(action: 'reject', remark: '描述不符'),
      );
      expect(result.status, 'rejected');
    });
  });
}
