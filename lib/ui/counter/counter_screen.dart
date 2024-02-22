import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_base_package/base/utils/utils.dart';
import '../../res/styles.dart';
import '../base/app_base_state.dart';
import 'bloc/bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(create: (context) => CounterBloc(), child: _CounterPage());
  }
}

class _CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends AppBaseState<_CounterPage> {
  late CounterBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<CounterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    if (SizeConfig().init(context)) {
      Log.d(SizeConfig().toString());
    }

    return Scaffold(
      appBar: setAppBar(context),
      body: setBody(context),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              //When you click it will update the state value from the bloc and stream it back to the UI
              //on line 75. Then the _bloc function will be redrawn and new counter value shown
              // and new counter value shown on line 86.
              _bloc.increaseCounter();
            },
            child: const Icon(Icons.exposure_plus_1),
          ),
          Style.microSpaceW,
          FloatingActionButton(
            onPressed: () {
              //When you click it will update the state value from the bloc and stream it back to the UI
              //on line 75. Then the _bloc function will be redrawn and new counter value shown
              // and new counter value shown on line 86.
              _bloc.decreaseCounter();
            },
            child: const Icon(Icons.exposure_minus_1),
          ),
        ],
      ),
    );
  }

  AppBar setAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
    );
  }

  Widget setBody(BuildContext context) {
    return BlocConsumer<CounterBloc, CounterState>(
      listener: (context, state) {
        _handleStateChanges(context, state);
      },
      builder: (context, state) {
        return _body(context, state);
      },
    );
  }

  Widget _body(BuildContext context, CounterState state) {
    return Center(child: Text(state.counter.toString(), style: Style.titleText.copyWith(fontSize: 50)));
  }

  ///For simplicity we don't have extra events to handle
  void _handleStateChanges(BuildContext context, CounterState state) {
    // if (state.showProgress) {
    //   showProgressIndicatorIfNotShowing();
    // }else{
    //   hideProgressIndicator();
    // }
    //
    // if (state.error != null) {
    //   showError(state.error);
    // }
  }

  @override
  String get tag => 'CounterPage';
}
