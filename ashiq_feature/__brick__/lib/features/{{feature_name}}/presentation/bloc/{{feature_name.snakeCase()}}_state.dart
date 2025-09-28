part of '{{feature_name.snakeCase()}}_bloc.dart';

abstract class {{feature_name.pascalCase()}}State extends Equatable {
  const {{feature_name.pascalCase()}}State();
}

class {{feature_name.pascalCase()}}Initial extends {{feature_name.pascalCase()}}State {
  @override
  List<Object> get props => [];
}

// class UserLoading extends UserState {
//   @override
//   List<Object> get props => [];
// }

// class UserLoaded extends UserState {
//   final User user;
//   const UserLoaded(this.user);

//   @override
//   List<Object> get props => [user];
// }

// class UserError extends UserState {
//   final String message;
//   const UserError(this.message);

//   @override
//   List<Object> get props => [message];
// }