enum ValidationState {
  initState,
  isLoading,
  valid,
  invalid,
}

extension DetermineValidateStaet on ValidationState  {
  bool get isValid {
    return this == ValidationState.valid ? true : false;
  }
}
