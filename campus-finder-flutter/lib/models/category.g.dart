// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  icon: json['icon'] as String?,
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
  createTime: json['createTime'] == null
      ? null
      : DateTime.parse(json['createTime'] as String),
);

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
  'sortOrder': instance.sortOrder,
  'createTime': instance.createTime?.toIso8601String(),
};
