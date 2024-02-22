import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g_base_package/base/flavor_config.dart';
import 'package:g_base_package/base/lang/localization.dart';
import 'package:g_base_package/base/utils/system.dart';

import '../res/colors.dart';
import '../res/dimensions.dart';
import '../res/strings/string_keys.dart';
import '../res/styles.dart';

/// Factory class for producing reusable Widgets and InputDecorations for the app UI
class UiUtils {
  static Widget buildRoundedButton(
      {Color? color,
      String? text,
      required Function() onClickAction,
      double? width,
      double? height,
      Widget? child,
      bool isToCenterMoreThanOneLine = false,
      double? corners}) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(corners ?? Dimen.cornersBig)),
      color: color,
      child: InkWell(
        splashFactory: InkSplash.splashFactory,
        borderRadius: BorderRadius.all(Radius.circular(corners ?? Dimen.cornersBig)),
        onTap: onClickAction,
        child: SizedBox(
            width: width,
            height: height,
            child: Center(
                child: child ??
                    Text(
                      text ?? '',
                      style: Style.btnText,
                      textAlign: isToCenterMoreThanOneLine ? TextAlign.center : null,
                    ))),
      ),
    );
  }

  static Widget emptyList(String text) {
    return SingleChildScrollView(
      child: SizedBox(
          width: Dimen.screenHorizontalFull,
          height: 300,
          child: Center(
              child: Text(
            text,
            style: Style.titleText,
          ))),
    );
  }

  static Widget buildRippleButton(
      {Color? color,
      BorderRadius? borderRadius,
      required Widget child,
      Function()? onClickAction,
      Function()? onLongClickAction}) {
    return Material(
        color: color ?? Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          splashFactory: InkSplash.splashFactory,
          borderRadius: borderRadius,
          onTap: onClickAction,
          onLongPress: onLongClickAction,
          child: child,
        ));
  }

  static Widget createRoundedCornersContainer(Widget body,
      {Color? color, double? corners, bool withShadow = false, double? width}) {
    return Container(
        width: width ?? SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: color ?? AppColors.appBackground,
          borderRadius: BorderRadius.all(Radius.circular(corners ?? Dimen.cornersBig)),
          boxShadow: withShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(1.0, 1.0),
                    blurRadius: 8.0,
                  ),
                ]
              : null,
        ),
        child: body);
  }

  static InputDecoration etInputDecoration(
      {String? label,
      String? hint,
      String? error,
      Widget? prefixIcon,
      Widget? suffixIcon,
      Function()? onTap,
      bool isDense = false,
      EdgeInsetsGeometry? contentPadding}) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      hintText: hint,
      errorText: error,
      errorStyle: Style.errorText,
      errorBorder: Style.etBorderErrorLine,
      focusedErrorBorder: Style.etBorderErrorLine,
      labelStyle: Style.etLabelText,
      alignLabelWithHint: true,
      contentPadding: contentPadding,
      isDense: isDense,
      hintStyle: Style.hintText,
      border: Style.etBorder,
      enabledBorder: Style.etBorder,
      disabledBorder: Style.etBorder,
      focusedBorder: Style.etBorder
          .copyWith(borderSide: const BorderSide(color: AppColors.accentColor, width: Dimen.widthOfTheInputBorder)),
    );
//    Style.etUnderLine
//    static final etUnderLine =
//    new UnderlineInputBorder(borderSide: new BorderSide(color: PolarColors.accentColor, width: 1));
  }

  static InputDecoration etInputDecorationAutoComplete(
      {String? label,
      String? hint,
      String? error,
      Widget? prefixIcon,
      Widget? suffixIcon,
      Function()? onTap,
      bool isDense = false,
      EdgeInsetsGeometry? contentPadding}) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      hintText: hint,
      errorText: error,
      errorStyle: Style.errorText,
      errorBorder: Style.etBorderErrorLine,
      focusedErrorBorder: Style.etBorderErrorLine,
      labelStyle: Style.etLabelText,
      alignLabelWithHint: true,
      contentPadding: contentPadding,
      isDense: isDense,
      hintStyle: Style.hintText,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );
//    Style.etUnderLine
//    static final etUnderLine =
//    new UnderlineInputBorder(borderSide: new BorderSide(color: PolarColors.accentColor, width: 1));
  }

  static InputDecoration etInputDecorationUnderline(
      {String? label,
      String? hint,
      String? error,
      Widget? prefixIcon,
      Widget? suffixIcon,
      Function? onTap,
      InputBorder? focusedBorder,
      EdgeInsets? padding,
      bool? isDense}) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      hintText: hint,
      errorText: error,
      isDense: isDense ?? false,
      isCollapsed: false,
      contentPadding: padding ?? const EdgeInsets.fromLTRB(12, 16, 12, 12),
      errorBorder: Style.etUnderErrorLine,
      focusedErrorBorder: Style.etUnderErrorLine,
      errorStyle: Style.errorText,
      labelStyle: Style.regularText,
      // alignLabelWithHint: true,
      hintStyle: Style.hintText,
      border: Style.etEnabledUnderLine,
      enabledBorder: Style.etEnabledUnderLine,
      disabledBorder: Style.etEnabledUnderLine,
      focusedBorder: focusedBorder ?? Style.etUnderLine,
    );
  }

  static InputDecoration inputDecorationWithoutBorderOnlyHint(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: Style.hintText,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );
  }

  static IconData backIcon() => Platform.isIOS ? Icons.chevron_left : Icons.arrow_back;

  static double backIconSize() => Platform.isIOS ? 40.0 : 24;


  ///A button widget that on click will show, a new
  ///page with all licenses extracted from the libraries,
  ///we use in the project.
  ///If the app has its own license add it either by creating a
  ///file LICENSE in the root directory of the project or
  ///add it manually on app start with :
  ///
  /// LicenseRegistry.addLicense(() async* {
  ///       yield LicenseEntryWithLineBreaks(
  ///         ["app name"],
  ///         "app contents",
  ///       );
  ///
  /// {@category UX Elements}
  /// {@category Widgets}
  static Widget buttonLicenses(
    BuildContext context, {
    Color? buttonColor,
    Color? licensesPrimaryColor,
    Color? licensesSecondaryColor,
    Color? licensesBackgroundColor,
    String? buttonText,
    String? appName,
    String? appVersion,
    String? applicationLegalese,
    Widget? appIcon,
    double? width,
    double? height,
  }) {
    return UiUtils.buildRoundedButton(
      color: buttonColor ?? AppColors.accentColor,
      height: height ?? Dimen.block * 3,
      onClickAction: () {
        //Show licenses page
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => Theme(
              data: ThemeData(
                primaryColor: licensesPrimaryColor ?? AppColors.accentColor,
                colorScheme: ColorScheme.light(
                  primary: licensesPrimaryColor ?? AppColors.accentColor,
                  secondary: licensesSecondaryColor ?? AppColors.accentColor,
                  background: licensesBackgroundColor ?? AppColors.appBackground,
                ),
              ),
              child: LicensePage(
                applicationName: appName,
                applicationVersion: appVersion ??
                    "${FlavorConfig.instance?.version ?? ''} (${FlavorConfig.instance?.buildNumber ?? ''})",
                applicationIcon: appIcon,
                applicationLegalese: applicationLegalese,
              )),
        ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimen.paddingSmall),
        child: Text(buttonText ?? Txt.get(StrKey.SUPPORT_ITEM_SHOW_LICENSES), style: Style.btnText,
          textAlign: TextAlign.center,),
      ),
    );
  }
}

/// Switch widget that updates status and appearance when swiped
///
///for some reason the switch widget on iOS stays on when is swiped but the status is false
///if we can not authorize and update the status again the status is the same and does not rebuild
///but the widget remains on. That is why we have a custom widget which makes sure the status
///will change
/// {@category UX Elements}
/// {@category Widgets}
class ProtectedSwitch extends StatefulWidget {
  final Future<bool> Function(bool) onChanged;
  final bool value;

  const ProtectedSwitch({Key? key, required this.onChanged, required this.value}) : super(key: key);

  @override
  ProtectedSwitchState createState() => ProtectedSwitchState();
}

class ProtectedSwitchState extends State<ProtectedSwitch> {
  late bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: (val) async {
        bool status = await widget.onChanged(val);
        if (value == status) {
          setState(() {
            value = !status;
          });
          await Future.delayed(const Duration(milliseconds: 200));
        }

        setState(() {
          value = status;
        });
      },
      value: value,
    );
  }
}

/// ScrollBehavior for each of SDK target platforms
///
/// {@category UX Elements}
class CustomScrollBehaviour extends MaterialScrollBehavior {
  const CustomScrollBehaviour();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
        return Scrollbar(
          controller: details.controller,
          child: child,
        );
      case TargetPlatform.windows:
        return Scrollbar(
          controller: details.controller,
          radius: Radius.zero,
          thickness: 16.0,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
      default:
        return child;
    }
  }
}
