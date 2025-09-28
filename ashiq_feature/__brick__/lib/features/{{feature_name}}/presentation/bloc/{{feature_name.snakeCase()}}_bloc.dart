import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart'
import '../../domain/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';

part '{{feature_name.snakeCase()}}_event.dart';
part '{{feature_name.snakeCase()}}_state.dart';

class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  final {{feature_name.pascalCase()}}UseCase {{feature_name.snakeCase()}}UseCase;
  {{feature_name.pascalCase()}}Controller({required this.{{feature_name.snakeCase()}}UseCase}) : super({{feature_name.pascalCase()}}InitialState());

  @override
  Stream<{{feature_name.pascalCase()}}State> mapEventToState({{feature_name.pascalCase()}}Event event) async* {
    // if (event is FetchUser) {
    //   yield UserLoading();
    //   try {
    //     final user = await getUserUseCase(event.userId);
    //     yield UserLoaded(user);
    //   } catch (e) {
    //     yield UserError(e.toString());
    //   }
    // }
  }
}