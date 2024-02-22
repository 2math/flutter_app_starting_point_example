import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimensions.dart';

///Here we store custom styles as TextStyles, Borders and etc.
///There are many predefined in [PolarStyle], which we will try to use as much as
///possible and make sure all apps are using same styles.
class Style {
  ///Extends Roboto font from regular text and show it with 110% of normal text size.
  static final TextStyle loginTitle = Style.regularText.copyWith(fontSize: Dimen.normalText * 1.1);

  static var appTheme = _generateAppTheme();

  ///this will generate new app theme to be loaded, will refresh primary and accent colors
  ///in future we should be able to load the font as well
  static ThemeData _generateAppTheme() {
    return ThemeData(
        primaryColor: AppColors.primaryColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.accentColor),
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.accentColor,
          background: AppColors.appBackground,
        ),
        textTheme: GoogleFonts.robotoTextTheme(
//          Theme.of(context).textTheme,
        ),
        scrollbarTheme: ScrollbarThemeData(
          //   //default value to all scrollbars
          thumbVisibility: MaterialStateProperty.all(true),
          thickness: MaterialStateProperty.all(10),
          //   trackVisibility: MaterialStateProperty.all(true),
          interactive: true,
        )
    );
  }

  static final regularText = GoogleFonts.roboto(
    color: AppColors.regularText,
    fontSize: Dimen.normalText,
    fontWeight: FontWeight.normal,
  );

  static final boldText = regularText.copyWith(fontWeight: FontWeight.bold);

  static final mediumText = regularText.copyWith(fontWeight: FontWeight.w600 /*fontFamily: "Gil
  roy-Medium"*/
  );

  static final lightText = regularText.copyWith(fontWeight: FontWeight.w100 /*fontFamily: "Gilroy
  -Light"*/
  );

  static final italicText = regularText.copyWith(fontStyle: FontStyle.italic);

  static final liteText =
  regularText.copyWith(color: AppColors.hintText, fontSize: Dimen.normalText, fontWeight: FontWeight.w100);

  static final titleText =
  regularText.copyWith(color: AppColors.darkText, fontSize: Dimen.titleTextSize, fontWeight: FontWeight.bold);

  static final titleScreen = titleText.copyWith(
    color: AppColors.lightText,
  );

  static final labelText = regularText.copyWith(color: AppColors.darkText);

  static final btnText = regularText.copyWith(fontSize: Dimen.buttonsText, color: AppColors.lightText);

  static final tabText =
  regularText.copyWith(color: AppColors.regularText, fontSize: Dimen.xBigText, fontWeight: FontWeight.w500);

  static const etUnderLine =
  UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor, width: 1));

  static const etUnderLineDark =
  UnderlineInputBorder(borderSide: BorderSide(color: AppColors.lightText, width: 1));

  static const etEnabledUnderLine =
  UnderlineInputBorder(borderSide: BorderSide(color: AppColors.btnBorder, width: 1));

  static const etUnderErrorLine =
  UnderlineInputBorder(borderSide: BorderSide(color: AppColors.errorText, width: 1));

  static const etBorderErrorLine = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.errorText, width: Dimen.widthOfTheInputBorder),
    borderRadius: BorderRadius.all(Radius.circular(Dimen.cornersBig)),
  );

  static const etBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.etBorder, width: Dimen.widthOfTheInputBorder),
    borderRadius: BorderRadius.all(Radius.circular(Dimen.cornersBig)),
  );

  static OutlineInputBorder etAccentBorder =
  etBorder.copyWith(borderSide: const BorderSide(color: AppColors.accentColor, width: Dimen.widthOfTheInputBorder));

  static const BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(Dimen.cornersBig),
      topRight: Radius.circular(Dimen.cornersBig),
      bottomLeft: Radius.circular(Dimen.cornersBig),
      bottomRight: Radius.circular(Dimen.cornersBig));

  static const BorderRadius borderRadiusSmall = BorderRadius.only(
      topLeft: Radius.circular(Dimen.cornersSmall),
      topRight: Radius.circular(Dimen.cornersSmall),
      bottomLeft: Radius.circular(Dimen.cornersSmall),
      bottomRight: Radius.circular(Dimen.cornersSmall));

  static final etText =
  regularText.copyWith(color: AppColors.regularText, fontSize: Dimen.etTextSize, fontWeight: FontWeight.normal);

  static final hintDropDown = hintText.copyWith(
    fontSize: Dimen.etTextSize * 0.75,
  );

  static final hintText =
  regularText.copyWith(color: AppColors.hintText, fontSize: Dimen.etTextSize, fontWeight: FontWeight.w300);

  static final etLabelText =
  regularText.copyWith(color: AppColors.etLabelText, fontSize: Dimen.etTextSize, fontWeight: FontWeight.w300);

  static final errorText =
  regularText.copyWith(color: AppColors.errorText, fontSize: Dimen.etTextSize, fontWeight: FontWeight.w300);

  static final statusText =
  regularText.copyWith(color: AppColors.accentColor, fontSize: Dimen.normalText, fontWeight: FontWeight.normal);

  static Widget safeAreaBottom = Container(
    color: AppColors.appBackground,
    height: Platform.isAndroid ? Dimen.paddingSmall : Dimen.safeAreaBottom,
  );

  static Widget safeAreaBottomWithColor({Color? color}) => Container(
    color: color ?? AppColors.primaryColor,
    height: Dimen.safeAreaBottom,
  );

  static final normalSpaceH = SizedBox(
    height: Dimen.paddingNormal,
  );

  static final normalSpaceW = SizedBox(
    width: Dimen.paddingNormal,
  );
  static final smallSpaceH = SizedBox(
    height: Dimen.paddingSmall,
  );
  static final smallSpaceW = SizedBox(
    width: Dimen.paddingSmall,
  );
  static final bigSpaceH = SizedBox(
    height: Dimen.paddingBig,
  );
  static final bigSpaceW = SizedBox(
    width: Dimen.paddingBig,
  );
  static final xbigSpaceH = SizedBox(
    height: Dimen.paddingXBig,
  );
  static final xbigSpaceW = SizedBox(
    width: Dimen.paddingXBig,
  );
  static final xxbigSpaceH = SizedBox(
    height: Dimen.paddingXXBig,
  );

  static final xxbigSpaceW = SizedBox(
    width: Dimen.paddingXXBig,
  );

  static final microSpaceH = SizedBox(
    height: Dimen.paddingMicro,
  );

  static final microSpaceW = SizedBox(
    width: Dimen.paddingMicro,
  );

  static final lineW = Container(
    height: 1,
    color: AppColors.line,
  );

  static final lineH = Container(
    width: 1,
    color: AppColors.line,
  );

  ///when you need to return a widget but has to be Gone
  static const emptySpace = SizedBox(
    height: 0,
    width: 0,
  );

  static const centerLoading = Center(
    child: CircularProgressIndicator(),
  );

  static const dropdownButtonStyle = TextStyle(color: AppColors.regularText);
  static final dropdownButtonUnderline = Container(height: 2, color: AppColors.accentColor);

  static final paddingScreenBottom = Platform.isAndroid ? Style.smallSpaceH : Style.safeAreaBottom;

}
