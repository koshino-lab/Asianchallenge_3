/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Icon.svg
  String get icon => 'assets/images/Icon.svg';

  /// File path: assets/images/container.png
  AssetGenImage get container =>
      const AssetGenImage('assets/images/container.png');

  /// File path: assets/images/key.png
  AssetGenImage get key => const AssetGenImage('assets/images/key.png');

  /// File path: assets/images/map.png
  AssetGenImage get map => const AssetGenImage('assets/images/map.png');

  /// File path: assets/images/pin1.svg
  String get pin1 => 'assets/images/pin1.svg';

  /// File path: assets/images/pin2.svg
  String get pin2 => 'assets/images/pin2.svg';

  /// File path: assets/images/pin3.svg
  String get pin3 => 'assets/images/pin3.svg';

  /// File path: assets/images/pin4.svg
  String get pin4 => 'assets/images/pin4.svg';

  /// File path: assets/images/pin5.svg
  String get pin5 => 'assets/images/pin5.svg';

  /// File path: assets/images/story1.png
  AssetGenImage get story1 => const AssetGenImage('assets/images/story1.png');

  /// File path: assets/images/story2.png
  AssetGenImage get story2 => const AssetGenImage('assets/images/story2.png');

  /// File path: assets/images/story3.png
  AssetGenImage get story3 => const AssetGenImage('assets/images/story3.png');

  /// List of all assets
  List<dynamic> get values => [
    icon,
    container,
    key,
    map,
    pin1,
    pin2,
    pin3,
    pin4,
    pin5,
    story1,
    story2,
    story3,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
