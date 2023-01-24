class TripsCreatorState {
  TripsCreatorState({
    required this.isLoading,
    required this.pathToSave,
    required this.fileToLoad,
  });

  final bool isLoading;
  final String pathToSave;
  final String fileToLoad;

  factory TripsCreatorState.initial() {
    return TripsCreatorState(
      isLoading: false,
      pathToSave: '',
      fileToLoad: '',
    );
  }

  factory TripsCreatorState.loading() {
    return TripsCreatorState.initial().copyWith(isLoading: true);
  }

  TripsCreatorState copyWith({
    bool? isLoading,
    String? pathToSave,
    String? fileToLoad,
  }) {
    return TripsCreatorState(
      isLoading: isLoading ?? this.isLoading,
      pathToSave: pathToSave ?? this.pathToSave,
      fileToLoad: fileToLoad ?? this.fileToLoad,
    );
  }
}
