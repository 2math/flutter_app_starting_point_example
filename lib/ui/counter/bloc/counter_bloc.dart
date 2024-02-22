import 'package:flutter_app_starting_point_example/ui/base/app_base_bloc.dart';
import 'package:g_base_package/base/utils/logger.dart';
import 'bloc.dart';

class CounterBloc extends AppBaseBloc<CounterEvent, CounterState> {
  @override
  String get tag => "CounterBloc";

  CounterBloc({CounterState? initialState}) : super(initialState ?? CounterState.initial()) {
    //Here it listens to the event OnCounter and updates the UI with new changed state.
    on<OnCounter>((event, emit) {
      Log.d("OnEvent $event", tag);
      emit(state.copyWith(counter: event.counter));
    });
  }

  void increaseCounter() {
    Log.d("OnClick increaseCounter $state", tag);
    //Add an event with new counter value, it will be received on line 10
    add(OnCounter(state.counter + 1));
  }

  void decreaseCounter() {
    Log.d("OnClick decreaseCounter $state", tag);
    //Add an event with new counter value, it will be received on line 10
    add(OnCounter(state.counter - 1));
  }
}
