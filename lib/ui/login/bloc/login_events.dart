import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

///Here we define our events that will happen in the Login screen and will be handled in the bloc.
///We have a base event LoginEvent and all other must extend from it, as each new event probably will
///contain some data that should be applied to the state.
@immutable
abstract class LoginEvent extends Equatable{
    @override
    List<Object?> get props => [];

    const LoginEvent();
}

class OnLoginSuccessfully extends LoginEvent {
    final bool? isLoginSuccessfully;

    const OnLoginSuccessfully(this.isLoginSuccessfully);

    @override
    List<Object?> get props => [isLoginSuccessfully];

    @override
    String toString() {
        return 'OnLoginSuccessfully{isLoginSuccessfully: $isLoginSuccessfully}';
    }
}

class OnInvalidUsername extends LoginEvent {
  final String? error;

  const OnInvalidUsername(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() {
    return 'OnInvalidUsername{error: $error}';
  }
}

class OnInvalidPassword extends LoginEvent {
  final String? error;

  const OnInvalidPassword(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() {
    return 'OnInvalidPassword{error: $error}';
  }
}

class ShowProgress extends LoginEvent {}

class HideProgress extends LoginEvent {}

class OnError extends LoginEvent {
    final dynamic  error;

    const OnError({required this.error});

    @override
    List<Object?> get props => [error];

    @override
    String toString() => 'OnError{ error: $error }';
}