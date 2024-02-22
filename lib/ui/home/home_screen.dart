import 'package:flutter/material.dart';
import 'package:g_base_package/base/lang/localization.dart';
import 'package:g_base_package/base/utils/logger.dart';
import 'package:g_base_package/base/utils/system.dart';

import '../../res/res.dart';
import '../../utils/ui_utils.dart';
import '../base/app_base_state.dart';
import '../login/login_screen.dart';

class HomePage extends StatefulWidget {
  //todo Galeen (17.11.23) : Convert to BLOC pattern, for now it uses the base widget state management.
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AppBaseState<HomePage> {
  @override
  void initState() {
    //Here is the place to init some data, if there is no bloc and have to
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (SizeConfig().init(context)) {
      Log.d(SizeConfig().toString());
    }

    return Scaffold(
      body: SizedBox(
        width: Dimen.screenHorizontalFull,
        child: Column(
          //this controls the layout of the children by vertical
          mainAxisAlignment: MainAxisAlignment.center,
          //this controls the layout of the children by horizontal
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Txt.get(StrKey.HOME_TITLE),
              style: Style.boldText.copyWith(fontSize: Dimen.xBigText * 1.3),
            ),
            Style.normalSpaceH,
            Text(
              "Hello, ${localRepository!.getSession()?.name}",
              style: Style.regularText,
            ),
            Style.normalSpaceH,
            //Remote image
            Image.network(
              'https://tommiaaltonen.fi/wp-content/uploads/2021/09/mitchell-luo-jz4ca36oJ_M-unsplash.jpg',
              height: Dimen.screenVerticalQuarter,
              fit: BoxFit.fitHeight,
            ),
            Style.normalSpaceH,
            //Here is an example how to load an image from the app assets.
            Image.asset(
              Img.icWatch,
              height: Dimen.screenVerticalQuarter,
              fit: BoxFit.fitHeight,
            ),
            Style.normalSpaceH,
            _logoutBtn(context),
          ],
        ),
      ),
    );
  }

  Widget _logoutBtn(BuildContext context) {
    return UiUtils.buildRoundedButton(
      color: AppColors.btnMain,
      corners: Dimen.cornersHuge,
      width: Dimen.block * 45,
      onClickAction: () {
        //This will remove current user's password
        localRepository!.logout();

        //Go back to login screen and remove all screens opened in the stack until now.
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
      },
      child: Padding(
        padding: EdgeInsets.all(Dimen.paddingMicro),
        child: Text(
          Txt.get(StrKey.BUTTON_LOG_OUT).toUpperCase(),
          style: Style.btnText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  String get tag => "Home screen";
}
