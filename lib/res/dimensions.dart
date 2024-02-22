import 'dart:io';
import 'dart:math';

import 'package:g_base_package/base/utils/system.dart';

///We try to construct our dimensions as a value of [Dimen.block] which
///is 1% of current screen width. If the app support landscape and portrait modes,
///we may want to use [Dimen.blockShortest] or [Dimen.blockBiggest], which
///will return always 1% of the width or height of the device screen, no mater the orientation.
class Dimen {
  static get isBigScreen => /*kIsWeb ||*/
  (SizeConfig.screenWidth! < SizeConfig.screenHeight! ? SizeConfig.screenWidth : SizeConfig.screenHeight)! > 550;

  static bool get isLandscape => SizeConfig.screenWidth! > SizeConfig.screenHeight!;

  static get block => !isLandscape || System().isDesktop()
      ? SizeConfig.safeBlockHorizontal
      : SizeConfig.safeBlockVertical;


  static get blockShortest => isLandscape ? SizeConfig.safeBlockVertical! : SizeConfig.safeBlockHorizontal!;

  ///It takes entire screen size without the padding, if you use blockShortest in landscape will return the
  ///usable screen height(without the screen status bar)
  static get blockShortestFromScreen => isLandscape ? SizeConfig.blockSizeVertical! : SizeConfig.blockSizeHorizontal!;

  static get blockBiggest => isLandscape ? SizeConfig.safeBlockHorizontal! : SizeConfig.safeBlockVertical!;

  static get screenHorizontalFull => block * 100;

  static get screenHorizontalHalf => block * 50;

  static get screenHorizontalQuarter => block * 25;

  static get screenVerticalQuarter =>
      (isLandscape ? SizeConfig.safeBlockHorizontal! : SizeConfig.safeBlockVertical!) * 25;

  static get screenVerticalFull => screenVerticalQuarter * 4;

  static get safeAreaBottom => SizeConfig.safeAreaBottom;

  static get safeAreaBottomCustom =>
      Platform.isAndroid || Dimen.safeAreaBottom! <= 0 ? Dimen.paddingSmall : Dimen.safeAreaBottom;

  static get paddingMicro => blockBiggest * (isBigScreen ? 1.0 : 1.5);

  static get paddingTiny => paddingMicro * 0.5;

  static get paddingSmall => blockBiggest * (isBigScreen ? 1.5 : 2.35);

  static get paddingNormal => paddingSmall * 2;

  static get paddingBig => paddingSmall * 3;

  static get paddingXBig => paddingSmall * 3.93;

  static get paddingXXBig => paddingSmall * 8.5;

  static get paddingEt => block * 3.35;
  static const etIconPadding = 12.0;
  static const cornersButton = 16.0;
  static const cornersBig = 14.0;
  static const cornersSmall = 4.0;
  static const cornersHuge = 23.0;
  static const widthOfTheInputBorder = 0.5;

  ///This is base size for all text sizes, it takes in count devicePixelRatio and textScaleFactor.
  ///With it we make sure the text size is taking the same proportion space on each screen.
  static get smallTextSize =>
      (isBigScreen
          ? (min<double>(blockBiggest / 1.3, 14.0) /
          (SizeConfig.mediaQueryData.devicePixelRatio == 1.0
              ? 1.0
              : max(SizeConfig.mediaQueryData.devicePixelRatio, 1.1)))
          : block * 2.0) /
          SizeConfig.mediaQueryData.textScaleFactor;

  static get normalText => smallTextSize * 1.7;

  static get bigText => normalText * 1.1;

  static get xBigText => normalText * 1.5;

  static get buttonsText => normalText * 1.3;

  static get etTextSize => smallTextSize * 2.2;

  static get titleTextSize => smallTextSize * 2.9;

  static get toolbarHeight => block * (Dimen.isLandscape ? 5.0 : 6.0);

  static get toolbarBtnSize => toolbarHeight - (paddingMicro * 2);

  ///70% of toolbarBtnSize
  static get btnIconSize => toolbarBtnSize * 0.7;

  static get btnHeight => block * (Dimen.isBigScreen ? 6.0 : 12.0);
  static get batteryIconSize => block * 5;
}
