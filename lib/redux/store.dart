class AppState {
 String value = "";

  AppState({ value});

  AppState.copyWith({ required AppState prev, required String value}) {
     this.value = prev.value;
  }
}
