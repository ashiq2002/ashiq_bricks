import 'package:json_annotation/json_annotation.dart';
part 'success_response.g.dart';

@JsonSerializable()
class SuccessResponse {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final dynamic data;

  SuccessResponse({
    this.success,
    this.message,
    this.data,
  });

  SuccessResponse copyWith({
    bool? success,
    String? message,
    dynamic data,
  }) =>
      SuccessResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SuccessResponse.fromJson(Map<String, dynamic> json) => _$SuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessResponseToJson(this);
}