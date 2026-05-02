// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lost_found_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LostFoundListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LostFoundListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LostFoundListState()';
}


}

/// @nodoc
class $LostFoundListStateCopyWith<$Res>  {
$LostFoundListStateCopyWith(LostFoundListState _, $Res Function(LostFoundListState) __);
}


/// Adds pattern-matching-related methods to [LostFoundListState].
extension LostFoundListStatePatterns on LostFoundListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ListInitial value)?  initial,TResult Function( ListLoading value)?  loading,TResult Function( ListLoaded value)?  loaded,TResult Function( ListError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ListInitial() when initial != null:
return initial(_that);case ListLoading() when loading != null:
return loading(_that);case ListLoaded() when loaded != null:
return loaded(_that);case ListError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ListInitial value)  initial,required TResult Function( ListLoading value)  loading,required TResult Function( ListLoaded value)  loaded,required TResult Function( ListError value)  error,}){
final _that = this;
switch (_that) {
case ListInitial():
return initial(_that);case ListLoading():
return loading(_that);case ListLoaded():
return loaded(_that);case ListError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ListInitial value)?  initial,TResult? Function( ListLoading value)?  loading,TResult? Function( ListLoaded value)?  loaded,TResult? Function( ListError value)?  error,}){
final _that = this;
switch (_that) {
case ListInitial() when initial != null:
return initial(_that);case ListLoading() when loading != null:
return loading(_that);case ListLoaded() when loaded != null:
return loaded(_that);case ListError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<LostFoundItem> items,  int currentPage,  bool hasMore,  List<Category> categories,  String? itemType,  int? categoryId,  String? status,  String keyword,  bool isLoadingMore)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ListInitial() when initial != null:
return initial();case ListLoading() when loading != null:
return loading();case ListLoaded() when loaded != null:
return loaded(_that.items,_that.currentPage,_that.hasMore,_that.categories,_that.itemType,_that.categoryId,_that.status,_that.keyword,_that.isLoadingMore);case ListError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<LostFoundItem> items,  int currentPage,  bool hasMore,  List<Category> categories,  String? itemType,  int? categoryId,  String? status,  String keyword,  bool isLoadingMore)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ListInitial():
return initial();case ListLoading():
return loading();case ListLoaded():
return loaded(_that.items,_that.currentPage,_that.hasMore,_that.categories,_that.itemType,_that.categoryId,_that.status,_that.keyword,_that.isLoadingMore);case ListError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<LostFoundItem> items,  int currentPage,  bool hasMore,  List<Category> categories,  String? itemType,  int? categoryId,  String? status,  String keyword,  bool isLoadingMore)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ListInitial() when initial != null:
return initial();case ListLoading() when loading != null:
return loading();case ListLoaded() when loaded != null:
return loaded(_that.items,_that.currentPage,_that.hasMore,_that.categories,_that.itemType,_that.categoryId,_that.status,_that.keyword,_that.isLoadingMore);case ListError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ListInitial implements LostFoundListState {
  const ListInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LostFoundListState.initial()';
}


}




/// @nodoc


class ListLoading implements LostFoundListState {
  const ListLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LostFoundListState.loading()';
}


}




/// @nodoc


class ListLoaded implements LostFoundListState {
  const ListLoaded({required final  List<LostFoundItem> items, required this.currentPage, required this.hasMore, required final  List<Category> categories, this.itemType, this.categoryId, this.status, this.keyword = '', this.isLoadingMore = false}): _items = items,_categories = categories;
  

 final  List<LostFoundItem> _items;
 List<LostFoundItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int currentPage;
 final  bool hasMore;
 final  List<Category> _categories;
 List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  String? itemType;
 final  int? categoryId;
 final  String? status;
@JsonKey() final  String keyword;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of LostFoundListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListLoadedCopyWith<ListLoaded> get copyWith => _$ListLoadedCopyWithImpl<ListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListLoaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.status, status) || other.status == status)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),currentPage,hasMore,const DeepCollectionEquality().hash(_categories),itemType,categoryId,status,keyword,isLoadingMore);

@override
String toString() {
  return 'LostFoundListState.loaded(items: $items, currentPage: $currentPage, hasMore: $hasMore, categories: $categories, itemType: $itemType, categoryId: $categoryId, status: $status, keyword: $keyword, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $ListLoadedCopyWith<$Res> implements $LostFoundListStateCopyWith<$Res> {
  factory $ListLoadedCopyWith(ListLoaded value, $Res Function(ListLoaded) _then) = _$ListLoadedCopyWithImpl;
@useResult
$Res call({
 List<LostFoundItem> items, int currentPage, bool hasMore, List<Category> categories, String? itemType, int? categoryId, String? status, String keyword, bool isLoadingMore
});




}
/// @nodoc
class _$ListLoadedCopyWithImpl<$Res>
    implements $ListLoadedCopyWith<$Res> {
  _$ListLoadedCopyWithImpl(this._self, this._then);

  final ListLoaded _self;
  final $Res Function(ListLoaded) _then;

/// Create a copy of LostFoundListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? currentPage = null,Object? hasMore = null,Object? categories = null,Object? itemType = freezed,Object? categoryId = freezed,Object? status = freezed,Object? keyword = null,Object? isLoadingMore = null,}) {
  return _then(ListLoaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LostFoundItem>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,itemType: freezed == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ListError implements LostFoundListState {
  const ListError({required this.message});
  

 final  String message;

/// Create a copy of LostFoundListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListErrorCopyWith<ListError> get copyWith => _$ListErrorCopyWithImpl<ListError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LostFoundListState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ListErrorCopyWith<$Res> implements $LostFoundListStateCopyWith<$Res> {
  factory $ListErrorCopyWith(ListError value, $Res Function(ListError) _then) = _$ListErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ListErrorCopyWithImpl<$Res>
    implements $ListErrorCopyWith<$Res> {
  _$ListErrorCopyWithImpl(this._self, this._then);

  final ListError _self;
  final $Res Function(ListError) _then;

/// Create a copy of LostFoundListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ListError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
