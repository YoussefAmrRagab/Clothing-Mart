import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/themes/colors.dart';
import '../../util/constants.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    super.key,
    required this.imageUrl,
    this.imageSize,
    required this.circularProgressIndicatorColor,
    this.circularProgressIndicatorColorHeight,
    this.circularProgressIndicatorColorWidth,
    required this.padding,
    this.fit,
  });

  final String imageUrl;
  final double? imageSize;
  final Color circularProgressIndicatorColor;
  final double? circularProgressIndicatorColorHeight;
  final double? circularProgressIndicatorColorWidth;
  final EdgeInsets padding;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: imageSize,
      width: imageSize,
      fit: fit,
      progressIndicatorBuilder: (_, __, ___) => SizedBox(
        height: circularProgressIndicatorColorHeight,
        width: circularProgressIndicatorColorWidth,
        child: Center(
          child: CircularProgressIndicator(
            color: circularProgressIndicatorColor,
          ),
        ),
      ),
      errorWidget: (_, __, ___) => Padding(
        padding: padding,
        child: Image.asset(
          Constants.errorAsset,
          color: ColorManager.primaryColor,
        ),
      ),
    );
  }
}
