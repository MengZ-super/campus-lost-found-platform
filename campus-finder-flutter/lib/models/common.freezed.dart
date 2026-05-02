// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Result<T> {

 int get code; String get message; T? get data; int? get timestamp;
/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultCopyWith<T, Result<T>> get copyWith => _$ResultCopyWithImpl<T, Result<T>>(this as Result<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Result<T>&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,const DeepCollectionEquality().hash(data),timestamp);

@override
String toString() {
  return 'Result<$T>(code: $code, message: $message, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ResultCopyWith<T,$Res>  {
  factory $ResultCopyWith(Result<T> value, $Res Function(Result<T>) _then) = _$ResultCopyWithImpl;
@useResult
$Res call({
 int code, String message, T? data, int? timestamp
});




}
/// @nodoc
class _$ResultCopyWithImpl<T,$Res>
    implements $ResultCopyWith<T, $Res> {
  _$ResultCopyWithImpl(this._self, this._then);

  final Result<T> _self;
  final $Res Function(Result<T>) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? data = freezed,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Result].
extension ResultPatterns<T> on Result<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Result<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Result<T> value)  $default,){
final _that = this;
switch (_that) {
case _Result():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Result<T> value)?  $default,){
final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String message,  T? data,  int? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that.code,_that.message,_that.data,_that.timestamp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String message,  T? data,  int? timestamp)  $default,) {final _that = this;
switch (_that) {
case _Result():
return $default(_that.code,_that.message,_that.data,_that.timestamp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String message,  T? data,  int? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _Result() when $default != null:
return $default(_that.code,_that.message,_that.data,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _Result<T> implements Result<T> {
  const _Result({required this.code, required this.message, this.data, this.timestamp});
  

@override final  int code;
@override final  String message;
@override final  T? data;
@override final  int? timestamp;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResultCopyWith<T, _Result<T>> get copyWith => __$ResultCopyWithImpl<T, _Result<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Result<T>&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,const DeepCollectionEquality().hash(data),timestamp);

@override
String toString() {
  return 'Result<$T>(code: $code, message: $message, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ResultCopyWith<T,$Res> implements $ResultCopyWith<T, $Res> {
  factory _$ResultCopyWith(_Result<T> value, $Res Function(_Result<T>) _then) = __$ResultCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, T? data, int? timestamp
});




}
/// @nodoc
class __$ResultCopyWithImpl<T,$Res>
    implements _$ResultCopyWith<T, $Res> {
  __$ResultCopyWithImpl(this._self, this._then);

  final _Result<T> _self;
  final $Res Function(_Result<T>) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? data = freezed,Object? timestamp = freezed,}) {
  return _then(_Result<T>(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$PageData<T> {

 int get current; int get size; int get total; int get pages; List<T> get records;
/// Create a copy of PageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageDataCopyWith<T, PageData<T>> get copyWith => _$PageDataCopyWithImpl<T, PageData<T>>(this as PageData<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageData<T>&&(identical(other.current, current) || other.current == current)&&(identical(other.size, size) || other.size == size)&&(identical(other.total, total) || other.total == total)&&(identical(other.pages, pages) || other.pages == pages)&&const DeepCollectionEquality().equals(other.records, records));
}


@override
int get hashCode => Object.hash(runtimeType,current,size,total,pages,const DeepCollectionEquality().hash(records));

@override
String toString() {
  return 'PageData<$T>(current: $current, size: $size, total: $total, pages: $pages, records: $records)';
}


}

/// @nodoc
abstract mixin class $PageDataCopyWith<T,$Res>  {
  factory $PageDataCopyWith(PageData<T> value, $Res Function(PageData<T>) _then) = _$PageDataCopyWithImpl;
@useResult
$Res call({
 int current, int size, int total, int pages, List<T> records
});




}
/// @nodoc
class _$PageDataCopyWithImpl<T,$Res>
    implements $PageDataCopyWith<T, $Res> {
  _$PageDataCopyWithImpl(this._self, this._then);

  final PageData<T> _self;
  final $Res Function(PageData<T>) _then;

/// Create a copy of PageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? current = null,Object? size = null,Object? total = null,Object? pages = null,Object? records = null,}) {
  return _then(_self.copyWith(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<T>,
  ));
}

}


/// Adds pattern-matching-related methods to [PageData].
extension PageDataPatterns<T> on PageData<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageData<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageData<T> value)  $default,){
final _that = this;
switch (_that) {
case _PageData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageData<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PageData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int current,  int size,  int total,  int pages,  List<T> records)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageData() when $default != null:
return $default(_that.current,_that.size,_that.total,_that.pages,_that.records);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int current,  int size,  int total,  int pages,  List<T> records)  $default,) {final _that = this;
switch (_that) {
case _PageData():
return $default(_that.current,_that.size,_that.total,_that.pages,_that.records);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int current,  int size,  int total,  int pages,  List<T> records)?  $default,) {final _that = this;
switch (_that) {
case _PageData() when $default != null:
return $default(_that.current,_that.size,_that.total,_that.pages,_that.records);case _:
  return null;

}
}

}

/// @nodoc


class _PageData<T> implements PageData<T> {
  const _PageData({required this.current, required this.size, required this.total, required this.pages, required final  List<T> records}): _records = records;
  

@override final  int current;
@override final  int size;
@override final  int total;
@override final  int pages;
 final  List<T> _records;
@override List<T> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}


/// Create a copy of PageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageDataCopyWith<T, _PageData<T>> get copyWith => __$PageDataCopyWithImpl<T, _PageData<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageData<T>&&(identical(other.current, current) || other.current == current)&&(identical(other.size, size) || other.size == size)&&(identical(other.total, total) || other.total == total)&&(identical(other.pages, pages) || other.pages == pages)&&const DeepCollectionEquality().equals(other._records, _records));
}


@override
int get hashCode => Object.hash(runtimeType,current,size,total,pages,const DeepCollectionEquality().hash(_records));

@override
String toString() {
  return 'PageData<$T>(current: $current, size: $size, total: $total, pages: $pages, records: $records)';
}


}

/// @nodoc
abstract mixin class _$PageDataCopyWith<T,$Res> implements $PageDataCopyWith<T, $Res> {
  factory _$PageDataCopyWith(_PageData<T> value, $Res Function(_PageData<T>) _then) = __$PageDataCopyWithImpl;
@override @useResult
$Res call({
 int current, int size, int total, int pages, List<T> records
});




}
/// @nodoc
class __$PageDataCopyWithImpl<T,$Res>
    implements _$PageDataCopyWith<T, $Res> {
  __$PageDataCopyWithImpl(this._self, this._then);

  final _PageData<T> _self;
  final $Res Function(_PageData<T>) _then;

/// Create a copy of PageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? current = null,Object? size = null,Object? total = null,Object? pages = null,Object? records = null,}) {
  return _then(_PageData<T>(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<T>,
  ));
}


}

// dart format on
