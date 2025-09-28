part of '{{feature_name.snakeCase()}}_bloc.dart';

abstract class {{feature_name.pascalCase()}}Event extends Equatable {
  const {{feature_name.pascalCase()}}Event();
}

class FetchUser extends {{feature_name.pascalCase()}}Event {
  final String userId;
  const FetchUser(this.userId);

  @override
  List<Object> get props => [userId];
}