// GENERATED CODE - DO NOT MODIFY BY HAND

part of '{{feature_name.snakeCase()}}_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

{{feature_name.pascalCase()}}Response _${{feature_name.pascalCase()}}ResponseFromJson(
        Map<String, dynamic> json) =>
    {{feature_name.pascalCase()}}Response(
      json['issuccess'] as bool?,
      (json['statusCode'] as num?)?.toInt(),
      json['message'] as String?,
      json['data'] == null
          ? null
          : {{feature_name.pascalCase()}}Response.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _${{feature_name.pascalCase()}}ResponseToJson(
        {{feature_name.pascalCase()}}Response instance) =>
    <String, dynamic>{
      'issuccess': instance.issuccess,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
