import 'package:bloc/bloc.dart';

class LucyBlocObserver extends BlocObserver{

  @override
  void onEvent(Cubit cubit, Object event) {
    super.onEvent(cubit, event);
    print(event);
  }

  @override
  void onTransition(Cubit cubit, Transition transition) {
    super.onTransition(cubit, transition);
    print(transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    super.onError(cubit, error, stacktrace);
    print(error);
  }
}