// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lost_found_detail_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LostFoundDetailEvent {

 int get id;
/// Create a copy of LostFoundDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LostFoundDetailEventCopyWith<LostFoundDetailEvent> get copyWith => _$LostFoundDetailEventCopyWithImpl<LostFoundDetailEvent>(this as LostFoundDetailEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LostFoundDetailEvent&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'LostFoundDetailEvent(id: $id)';
}


}

/// @nodoc
abstract mixin class $LostFoundDetailEventCopyWith<$Res>  {
  factory $LostFoundDetailEventCopyWith(LostFoundDetailEvent value, $Res Function(LostFoundDetailEvent) _then) = _$LostFoundDetailEventCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$LostFoundDetailEventCopyWithImpl<$Res>
    implements $LostFoundDetailEventCopyWith<$Res> {
  _$LostFoundDetailEventCopyWithImpl(this._self, this._then);

  final LostFoundDetailEvent _self;
  final $Res Function(LostFoundDetailEvent) _then;

/// Create a copy of LostFoundDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LostFoundDetailEvent].
extension LostFoundDetailEventPatterns on LostFoundDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadDetail value)?  loadDetail,TResult Function( ToggleFavorite value)?  toggleFavorite,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadDetail() when loadDetail != null:
return loadDetail(_that);case ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadDetail value)  loadDetail,required TResult Function( ToggleFavorite value)  toggleFavorite,}){
final _that = this;
switch (_that) {
case LoadDetail():
return loadDetail(_that);case ToggleFavorite():
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadDetail value)?  loadDetail,TResult? Function( ToggleFavorite value)?  toggleFavorite,}){
final _that = this;
switch (_that) {
case LoadDetail() when loadDetail != null:
return loadDetail(_that);case ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int id)?  loadDetail,TResult Function( int id)?  toggleFavorite,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadDetail() when loadDetail != null:
return loadDetail(_that.id);case ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int id)  loadDetail,required TResult Function( int id)  toggleFavorite,}) {final _that = this;
switch (_that) {
case LoadDetail():
return loadDetail(_that.id);case ToggleFavorite():
return toggleFavorite(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int id)?  loadDetail,TResult? Function( int id)?  toggleFavorite,}) {final _that = this;
switch (_that) {
case LoadDetail() when loadDetail != null:
return loadDetail(_that.id);case ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class LoadDetail implements LostFoundDetailEvent {
  const LoadDetail({required this.id});
  

@override final  int id;

/// Create a copy of LostFoundDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadDetailCopyWith<LoadDetail> get copyWith => _$LoadDetailCopyWithImpl<LoadDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadDetail&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'LostFoundDetailEvent.loadDetail(id: $id)';
}


}

/// @nodoc
abstract mixin class $LoadDetailCopyWith<$Res> implements $LostFoundDetailEventCopyWith<$Res> {
  factory $LoadDetailCopyWith(LoadDetail value, $Res Function(LoadDetail) _then) = _$LoadDetailCopyWithImpl;
@override @useResult
$Res call({
 int id
});




}
/// @nodoc
class _$LoadDetailCopyWithImpl<$Res>
    implements $LoadDetailCopyWith<$Res> {
  _$LoadDetailCopyWithImpl(this._self, this._then);

  final LoadDetail _self;
  final $Res Function(LoadDetail) _then;

/// Create a copy of LostFoundDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(LoadDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ToggleFavorite implements LostFoundDetailEvent {
  const ToggleFavorite({required this.id});
  

@override final  int id;

/// Create a copy of LostFoundDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleFavoriteCopyWith<ToggleFavorite> get copyWith => _$ToggleFavoriteCopyWithImpl<ToggleFavorite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleFavorite&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'LostFoundDetailEvent.toggleFavorite(id: $id)';
}


}

/// @nodoc
abstract mixin class $ToggleFavoriteCopyWith<$Res> implements $LostFoundDetailEventCopyWith<$Res> {
  factory $ToggleFavoriteCopyWith(ToggleFavorite value, $Res Function(ToggleFavorite) _then) = _$ToggleFavoriteCopyWithImpl;
@override @useResult
$Res call({
 int id
});




}
/// @nodoc
class _$ToggleFavoriteCopyWithImpl<$Res>
    implements $ToggleFavoriteCopyWith<$Res> {
  _$ToggleFavoriteCopyWithImpl(this._self, this._then);

  final ToggleFavorite _self;
  final $Res Function(ToggleFavorite) _then;

/// Create a copy of LostFoundDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ToggleFavorite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
