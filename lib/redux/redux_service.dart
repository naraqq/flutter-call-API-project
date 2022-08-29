enum CounterActions { Increment, Decrement, Reset }

class ReduxActions {
  static int counterUpdate(int state, dynamic action) {
    if (action == CounterActions.Increment) {
      return state + 1;
    } else if (action == CounterActions.Decrement) {
      return (state - 1).toUnsigned(state.bitLength);
    } else if (action == CounterActions.Reset) {
      state = 0;
      return state;
    } else
      return state;
  }
}