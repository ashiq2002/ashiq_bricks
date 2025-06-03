import 'package:flutter_bloc/flutter_bloc.dart';

class {{feature_name.pascalCase()}}Bloc extends Cubit<String> {
  {{feature_name.pascalCase()}}Bloc() : super('Initial');

  void load() => emit('Loaded');
}