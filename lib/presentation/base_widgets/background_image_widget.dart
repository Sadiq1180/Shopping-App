import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/shared.dart';

class BackgroundImageWidget extends ConsumerWidget {
  final Widget? child;
  final String imagePath;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final Color? color;
  final BoxFit fit;
  final bool isTop;
  const BackgroundImageWidget(
      {super.key,
      this.child,
      this.alignment,
      required this.imagePath,
      this.width,
      this.color,
      this.isTop = false,
      this.fit = BoxFit.fill,
      //   Type appAssets,
      this.height});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height,
      width: double.infinity, // width ?? MediaQuery.of(context).size.width,
      color: color ?? context.theme.scaffoldBackgroundColor,
      child:const Stack(
        children: [
          // if (alignment == null)
          //   SvgPicture.asset(
          //     imagePath,
          //     fit: BoxFit.fill,
          //     height: height ?? double.infinity,
          //     width: width ?? double.infinity,
          //   ),
          // if (alignment != null)
          //   Align(
          //     alignment: alignment ?? Alignment.center,
          //     child: SvgPicture.asset(
          //       imagePath,
          //       fit: fit,
          //     ),
          //   ),
          // child ?? SizedBox(),
        ],
      ),
    );
  }
}
