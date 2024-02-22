

import 'package:g_base_package/base/flavor_config.dart';

import '../main.dart';
import 'app_base_flavor.dart';

///This is entrypoint for DEV build.
///Currently will be connected to the dev server. It has an option to send the new serverUrl
///and change it dynamically, in that case "force" should be set to TRUE
void main() {
  DevConfig();
  MainApp().run();
}

class DevConfig extends AppBaseConfig {
  DevConfig({String? serverUrl, bool? force})
      : super(
          Flavor.DEV,
          //fake server
          baseUrl: serverUrl ?? 'https://jsonplaceholder.typicode.com/',
          force: force ?? false,
        );
}
