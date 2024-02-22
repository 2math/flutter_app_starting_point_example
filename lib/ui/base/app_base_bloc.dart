import 'package:g_base_package/base/ui/base_bloc.dart';
import 'package:g_base_package/base/utils/logger.dart';
import '../../repository/local_repository.dart';
import '../../repository/remote_repository.dart';

///This is subclass of the [BaseBloc].
///In general each Bloc should extend from it.
///It provides us with local and remote repositories, which are manually injected in the super constructor.
///Also will print in the logs when a transition is happening from one event, what is the event and how the state was
///has changed. You can control that by overriding the [printBlocLogs] getter to return false.
abstract class AppBaseBloc<Event, State> extends BaseBloc<Event, State, RemoteRepository, LocalRepository> {
  AppBaseBloc(State initialState) : super(initialState) {
    Log.i("init", tag);
  }

  @override
  Future<void> close() {
    Log.i("close", tag);
    return super.close();
  }
}
