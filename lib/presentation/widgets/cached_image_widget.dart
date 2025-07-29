// import '../../shared/constants/app_colors.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class CachedImageWidget extends StatelessWidget {
//   final String imageUrl;
//   final double? width;
//   final double? height;
//   final BoxFit fit;

//   const CachedImageWidget(
//     this.imageUrl, {
//     super.key,
//     this.width,
//     this.height,
//     this.fit = BoxFit.cover,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       width: width,
//       height: height,
//       fit: fit,
//       placeholder: (context, url) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//       errorWidget: (context, url, error) => const Icon(
//         Icons.error,
//         color: AppColors.brown,
//       ),
//     );
//   }
// }
