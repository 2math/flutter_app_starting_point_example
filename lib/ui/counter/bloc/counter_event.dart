import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CounterEvent extends Equatable{
    @override
    List<Object?> get props => [];

    const CounterEvent();
}

class OnCounter extends CounterEvent {
    final int counter;

    const OnCounter(this.counter);

    @override
    List<Object?> get props => [counter];

    @override
    String toString() {
        return 'OnCounter{counter: $counter}';
    }
}
