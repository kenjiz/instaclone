// ignore_for_file: public_member_api_docs

import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    required this.fit,
    this.color,
    this.width,
    this.height,
    super.key,
  });

  final Color? color;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Assets.images.instagramTextLogo.svg(
      width: width ?? 50,
      height: height ?? 50,
      fit: fit,
      colorFilter: ColorFilter.mode(
        color ?? context.adaptiveColor,
        BlendMode.srcIn,
      ),
    );
  }
}
