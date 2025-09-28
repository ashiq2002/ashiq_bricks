part of 'user_bloc.dart';

abstract class {{feature_name.pascalCase()}}Event extends Equatable {
  const {{feature_name.pascalCase()}}Event;
}

// class FetchUser extends UserEvent {
//   final String userId;
//   const FetchUser(this.userId);

//   @override
//   List<Object> get props => [userId];
// }