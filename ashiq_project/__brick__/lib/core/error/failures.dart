class Failure {
  final String? message;
  final int? statusCode;
  final String? constrain;
  Failure({
    this.message,
    this.statusCode,
    this.constrain,
  });

  @override
  String toString() {
    return 'Failure(message: $message, statusCode: $statusCode, constrain: $constrain)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.message == message &&
        other.statusCode == statusCode &&
        other.constrain == constrain;
  }
  
  @override
  int get hashCode {
    return message.hashCode ^ statusCode.hashCode ^ constrain.hashCode;
  }
}