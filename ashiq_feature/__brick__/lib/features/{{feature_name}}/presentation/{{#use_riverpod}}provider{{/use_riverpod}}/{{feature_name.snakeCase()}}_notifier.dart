import 'package:flutter_riverpod/flutter_riverpod.dart';
import '{{feature_name.snakeCase()}}_state.dart';

class {{feature_name.pascalCase()}}Notifier extends Notifier<{{feature_name.pascalCase()}}State> {

  @override
  {{feature_name.pascalCase()}}State build() {
    return const {{feature_name.pascalCase()}}State();
  }

  Future<void> load() async {
    final usecase = ref.read(get{{feature_name.pascalCase()}}Provider);

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await usecase();

      state = state.copyWith(
        isLoading: false,
        items: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}