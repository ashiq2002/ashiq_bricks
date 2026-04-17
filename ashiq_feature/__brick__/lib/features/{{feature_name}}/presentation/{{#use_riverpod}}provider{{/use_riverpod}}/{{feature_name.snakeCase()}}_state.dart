class {{feature_name.pascalCase()}}State {
  final bool isLoading;
  final String? error;

  const {{feature_name.pascalCase()}}State({
    this.isLoading = false,
    this.error,
  });

  {{feature_name.pascalCase()}}State copyWith({
    bool? isLoading,
    String? error,
  }) {
    return {{feature_name.pascalCase()}}State(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
