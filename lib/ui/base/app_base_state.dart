import 'package:flutter/material.dart';
import 'package:g_base_package/base/utils/logger.dart';
import 'package:g_base_package/base/ui/base_state.dart';

import '../../repository/local_repository.dart';
import '../../repository/remote_repository.dart';


///This is a subclass of the [BaseState].
///In general each widget that represent a screen should extend from it, but not only.
///We can add additional functions here to be available to all widgets or override functions from
///the super class. Good example to override a function is the [showError] function for example.
abstract class AppBaseState<T extends StatefulWidget> extends BaseState<T, RemoteRepository, LocalRepository> {
  @override
  void dispose() {
    Log.d("dispose", tag);
    super.dispose();
  }
}
