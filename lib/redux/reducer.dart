import 'package:init/redux/actions.dart';
import 'package:init/redux/store.dart';

AppState reducer(AppState prevState, Action action) {
  AppState newState;

  if (action is UpdateValue) {
    print(action);
    print(action.payload);
    newState = AppState.copyWith(prev: prevState, value: action.payload);
    print(newState);
    print(newState.value);
  } else if (action is Convert) {
    print(action);
    // newState = AppState.copyWith(prev: prevState, value: action.payload);
  }
  return newState;
}
