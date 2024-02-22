import 'package:g_base_package/base/flavor_config.dart';

import '../main.dart';
import 'app_base_flavor.dart';

void main() {
  ProdConfig();
  MainApp().run();
}

class ProdConfig extends AppBaseConfig {
  ProdConfig()
      : super(
          Flavor.PROD,
          //fake server
          baseUrl: 'https://jsonplaceholder.typicode.com/',
        );
}
