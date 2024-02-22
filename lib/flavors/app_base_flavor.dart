import 'package:g_base_package/base/flavor_config.dart';

import '../res/strings/string_keys.dart';

///Custom app config file for each application. Each app flavor must extend from it,
///so all flavors will share same fields. Common data should be set here.
abstract class AppBaseConfig extends FlavorConfig {
  static AppBaseConfig? _instance;

  AppBaseConfig(
    Flavor flavor, {
    required String baseUrl,
    bool force = false,
  }) : super(
          flavor,
          baseUrl: baseUrl,
          force: force,
          noNetworkKey: StrKey.ERROR_PARAGRAPH_NO_NETWORK,
          socketExceptionKey: StrKey.ERROR_PARAGRAPH_NO_NETWORK,
          //500
          serverErrorKey: StrKey.ERROR_PARAGRAPH_500_INTERNAL_SERVER_ERROR,
          //401
          unauthorizedKey: StrKey.ERROR_PARAGRAPH_401_NO_OR_INVALID_CREDENTIALS,
          //403
          forbiddenKey: StrKey.ERROR_PARAGRAPH_403_NOT_ENOUGH_PRIVILEGES,
          //404
          notFoundKey: StrKey.ERROR_PARAGRAPH_404_PAGE_NOT_FOUND,
          headerToken: "Authorization",
          headerContentType: "Content-Type",
        ) {
    if (force || _instance == null) {
      _instance ??= this;
    }
  }

  static AppBaseConfig get instance {
    return _instance!;
  }
}
