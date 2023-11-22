/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsPngsGen {
  const $AssetsPngsGen();

  /// File path: assets/pngs/app_icon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/pngs/app_icon.png');

  /// File path: assets/pngs/google_logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/pngs/google_logo.png');

  /// File path: assets/pngs/mail_sent_success.png
  AssetGenImage get mailSentSuccess =>
      const AssetGenImage('assets/pngs/mail_sent_success.png');

  /// File path: assets/pngs/onboarding_first_step.png
  AssetGenImage get onboardingFirstStep =>
      const AssetGenImage('assets/pngs/onboarding_first_step.png');

  /// File path: assets/pngs/onboarding_second_step.png
  AssetGenImage get onboardingSecondStep =>
      const AssetGenImage('assets/pngs/onboarding_second_step.png');

  /// File path: assets/pngs/onboarding_third_step.png
  AssetGenImage get onboardingThirdStep =>
      const AssetGenImage('assets/pngs/onboarding_third_step.png');

  /// File path: assets/pngs/verify_email.png
  AssetGenImage get verifyEmail =>
      const AssetGenImage('assets/pngs/verify_email.png');

  /// File path: assets/pngs/welcome_banner.png
  AssetGenImage get welcomeBanner =>
      const AssetGenImage('assets/pngs/welcome_banner.png');

  /// File path: assets/pngs/welldone_green.png
  AssetGenImage get welldoneGreen =>
      const AssetGenImage('assets/pngs/welldone_green.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        appIcon,
        googleLogo,
        mailSentSuccess,
        onboardingFirstStep,
        onboardingSecondStep,
        onboardingThirdStep,
        verifyEmail,
        welcomeBanner,
        welldoneGreen
      ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/gender_icon.svg
  SvgGenImage get genderIcon =>
      const SvgGenImage('assets/svgs/gender_icon.svg');

  /// File path: assets/svgs/ic_error.svg
  SvgGenImage get icError => const SvgGenImage('assets/svgs/ic_error.svg');

  /// File path: assets/svgs/ic_error_circle.svg
  SvgGenImage get icErrorCircle =>
      const SvgGenImage('assets/svgs/ic_error_circle.svg');

  /// File path: assets/svgs/ic_filled_info_circle.svg
  SvgGenImage get icFilledInfoCircle =>
      const SvgGenImage('assets/svgs/ic_filled_info_circle.svg');

  /// File path: assets/svgs/ic_ongoing.svg
  SvgGenImage get icOngoing => const SvgGenImage('assets/svgs/ic_ongoing.svg');

  /// File path: assets/svgs/ic_success.svg
  SvgGenImage get icSuccess => const SvgGenImage('assets/svgs/ic_success.svg');

  /// File path: assets/svgs/ic_success_circle.svg
  SvgGenImage get icSuccessCircle =>
      const SvgGenImage('assets/svgs/ic_success_circle.svg');

  /// File path: assets/svgs/ic_upcoming.svg
  SvgGenImage get icUpcoming =>
      const SvgGenImage('assets/svgs/ic_upcoming.svg');

  /// File path: assets/svgs/ic_warning.svg
  SvgGenImage get icWarning => const SvgGenImage('assets/svgs/ic_warning.svg');

  /// File path: assets/svgs/ic_warning_circle.svg
  SvgGenImage get icWarningCircle =>
      const SvgGenImage('assets/svgs/ic_warning_circle.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        genderIcon,
        icError,
        icErrorCircle,
        icFilledInfoCircle,
        icOngoing,
        icSuccess,
        icSuccessCircle,
        icUpcoming,
        icWarning,
        icWarningCircle
      ];
}

class Assets {
  Assets._();

  static const $AssetsPngsGen pngs = $AssetsPngsGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package = 'resources',
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package = 'resources',
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/resources/$_assetName';
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package = 'resources',
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/resources/$_assetName';
}
