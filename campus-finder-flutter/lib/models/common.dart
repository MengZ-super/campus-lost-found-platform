import 'package:freezed_annotation/freezed_annotation.dart';

part 'common.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result({
    required int code,
    required String message,
    T? data,
    int? timestamp,
  }) = _Result;

  factory Result.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return Result(
      code: json['code'] as int,
      message: json['message'] as String? ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      timestamp: json['timestamp'] as int?,
    );
  }
}

@freezed
abstract class PageData<T> with _$PageData<T> {
  const factory PageData({
    required int current,
    required int size,
    required int total,
    required int pages,
    required List<T> records,
  }) = _PageData;

  factory PageData.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return PageData(
      current: json['current'] as int? ?? 1,
      size: json['size'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
      pages: json['pages'] as int? ?? 0,
      records: (json['records'] as List<dynamic>?)
              ?.map((e) => fromJsonT(e))
              .toList() ??
          [],
    );
  }
}
