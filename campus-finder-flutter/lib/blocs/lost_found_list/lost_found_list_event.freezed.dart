// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lost_found_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LostFoundListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LostFoundListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LostFoundListEvent()';
}


}

/// @nodoc
class $LostFoundListEventCopyWith<$Res>  {
$LostFoundListEventCopyWith(LostFoundListEvent _, $Res Function(LostFoundListEvent) __);
}


/// Adds pattern-matching-related methods to [LostFoundListEvent].
extension LostFoundListEventPatterns on LostFoundListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ListLoadList value)?  loadList,TResult Function( ListSearchChanged value)?  searchChanged,TResult Function( ListFilterChanged value)?  filterChanged,TResult Function( ListLoadMore value)?  loadMore,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ListLoadList() when loadList != null:
return loadList(_that);case ListSearchChanged() when searchChanged != null:
return searchChanged(_that);case ListFilterChanged() when filterChanged != null:
return filterChanged(_that);case ListLoadMore() when loadMore != null:
return loadMore(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ListLoadList value)  loadList,required TResult Function( ListSearchChanged value)  searchChanged,required TResult Function( ListFilterChanged value)  filterChanged,required TResult Function( ListLoadMore value)  loadMore,}){
final _that = this;
switch (_that) {
case ListLoadList():
return loadList(_that);case ListSearchChanged():
return searchChanged(_that);case ListFilterChanged():
return filterChanged(_that);case ListLoadMore():
return loadMore(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ListLoadList value)?  loadList,TResult? Function( ListSearchChanged value)?  searchChanged,TResult? Function( ListFilterChanged value)?  filterChanged,TResult? Function( ListLoadMore value)?  loadMore,}){
final _that = this;
switch (_that) {
case ListLoadList() when loadList != null:
return loadList(_that);case ListSearchChanged() when searchChanged != null:
return searchChanged(_that);case ListFilterChanged() when filterChanged != null:
return filterChanged(_that);case ListLoadMore() when loadMore != null:
return loadMore(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadList,TResult Function( String keyword)?  searchChanged,TResult Function( String? itemType,  int? categoryId,  String? status)?  filterChanged,TResult Function()?  loadMore,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ListLoadList() when loadList != null:
return loadList();case ListSearchChanged() when searchChanged != null:
return searchChanged(_that.keyword);case ListFilterChanged() when filterChanged != null:
return filterChanged(_that.itemType,_that.categoryId,_that.status);case ListLoadMore() when loadMore != null:
return loadMore();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadList,required TResult Function( String keyword)  searchChanged,required TResult Function( String? itemType,  int? categoryId,  String? status)  filterChanged,required TResult Function()  loadMore,}) {final _that = this;
switch (_that) {
case ListLoadList():
return loadList();case ListSearchChanged():
return searchChanged(_that.keyword);case ListFilterChanged():
return filterChanged(_that.itemType,_that.categoryId,_that.status);case ListLoadMore():
return loadMore();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadList,TResult? Function( String keyword)?  searchChanged,TResult? Function( String? itemType,  int? categoryId,  String? status)?  filterChanged,TResult? Function()?  loadMore,}) {final _that = this;
switch (_that) {
case ListLoadList() when loadList != null:
return loadList();case ListSearchChanged() when searchChanged != null:
return searchChanged(_that.keyword);case ListFilterChanged() when filterChanged != null:
return filterChanged(_that.itemType,_that.categoryId,_that.status);case ListLoadMore() when loadMore != null:
return loadMore();case _:
  return null;

}
}

}

/// @nodoc


class ListLoadList implements LostFoundListEvent {
  const ListLoadList();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListLoadList);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LostFoundListEvent.loadList()';
}


}




/// @nodoc


class ListSearchChanged implements LostFoundListEvent {
  const ListSearchChanged(this.keyword);
  

 final  String keyword;

/// Create a copy of LostFoundListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListSearchChangedCopyWith<ListSearchChanged> get copyWith => _$ListSearchChangedCopyWithImpl<ListSearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListSearchChanged&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,keyword);

@override
String toString() {
  return 'LostFoundListEvent.searchChanged(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class $ListSearchChangedCopyWith<$Res> implements $LostFoundListEventCopyWith<$Res> {
  factory $ListSearchChangedCopyWith(ListSearchChanged value, $Res Function(ListSearchChanged) _then) = _$ListSearchChangedCopyWithImpl;
@useResult
$Res call({
 String keyword
});




}
/// @nodoc
class _$ListSearchChangedCopyWithImpl<$Res>
    implements $ListSearchChangedCopyWith<$Res> {
  _$ListSearchChangedCopyWithImpl(this._self, this._then);

  final ListSearchChanged _self;
  final $Res Function(ListSearchChanged) _then;

/// Create a copy of LostFoundListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = null,}) {
  return _then(ListSearchChanged(
null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ListFilterChanged implements LostFoundListEvent {
  const ListFilterChanged({this.itemType, this.categoryId, this.status});
  

 final  String? itemType;
 final  int? categoryId;
 final  String? status;

/// Create a copy of LostFoundListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListFilterChangedCopyWith<ListFilterChanged> get copyWith => _$ListFilterChangedCopyWithImpl<ListFilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListFilterChanged&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,itemType,categoryId,status);

@override
String toString() {
  return 'LostFoundListEvent.filterChanged(itemType: $itemType, categoryId: $categoryId, status: $status)';
}


}

/// @nodoc
abstract mixin class $ListFilterChangedCopyWith<$Res> implements $LostFoundListEventCopyWith<$Res> {
  factory $ListFilterChangedCopyWith(ListFilterChanged value, $Res Function(ListFilterChanged) _then) = _$ListFilterChangedCopyWithImpl;
@useResult
$Res call({
 String? itemType, int? categoryId, String? status
});




}
/// @nodoc
class _$ListFilterChangedCopyWithImpl<$Res>
    implements $ListFilterChangedCopyWith<$Res> {
  _$ListFilterChangedCopyWithImpl(this._self, this._then);

  final ListFilterChanged _self;
  final $Res Function(ListFilterChanged) _then;

/// Create a copy of LostFoundListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemType = freezed,Object? categoryId = freezed,Object? status = freezed,}) {
  return _then(ListFilterChanged(
itemType: freezed == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ListLoadMore implements LostFoundListEvent {
  const ListLoadMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListLoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LostFoundListEvent.loadMore()';
}


}




// dart format on
