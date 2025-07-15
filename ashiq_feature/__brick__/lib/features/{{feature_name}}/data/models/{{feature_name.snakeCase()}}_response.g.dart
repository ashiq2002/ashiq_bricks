// GENERATED CODE - DO NOT MODIFY BY HAND

part of '{{feature_name.snakeCase()}}_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

{{feature_name.pascalCase()}}Response _${{feature_name.pascalCase()}}ResponseFromJson(
        Map<String, dynamic> json) =>
    {{feature_name.pascalCase()}}Response(
      message: json['message'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      isSuccess: json['is_success'] as bool?,
      data: json['data']
    );

Map<String, dynamic> _${{feature_name.pascalCase()}}ResponseToJson(
        {{feature_name.pascalCase()}}Response instance) =>
    <String, dynamic>{
      'issuccess': instance.issuccess,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
