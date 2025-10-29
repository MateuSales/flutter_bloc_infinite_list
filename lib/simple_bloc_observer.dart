import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

final class SimpleBlocObserver extends BlocObserver {
  const SimpleBlocObserver();

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint(error.toString());
    super.onError(bloc, error, stackTrace);
  }
}