// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
  name: json['name'] as String,
  description: json['description'] as String?,
  url: json['url'] as String?,
  category: json['category'] as String?,
  language: json['language'] as String?,
  country: json['country'] as String?,
  id: json['id'] as String?,
);

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'url': instance.url,
  'category': instance.category,
  'language': instance.language,
  'country': instance.country,
};
