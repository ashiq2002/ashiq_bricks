import 'package:json_annotation/json_annotation.dart';
part '{{feature_name}}_response.g.dart';


@JsonSerializable()
class {{feature_name.pascalCase()}}Response {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey(name: 'is_success')
  final bool? isSuccess;
  @JsonKey(name: 'data')
  final dynamic data;

  {{feature_name.pascalCase()}}Response({
    this.message,
    this.statusCode,
    this.isSuccess,
    this.data,
  });

  factory {{feature_name.pascalCase()}}Response.fromJson(Map<String, dynamic> json) =>
      _${{feature_name.pascalCase()}}ResponseFromJson(json);

  Map<String, dynamic> toJson() => _${{feature_name.pascalCase()}}ResponseToJson(this);
}
