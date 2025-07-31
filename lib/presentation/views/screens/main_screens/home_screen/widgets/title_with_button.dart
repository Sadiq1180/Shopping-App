import 'package:flutter/material.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';

class TitleWithOptionalButton extends StatelessWidget {
  final String title;
  final bool showButton;
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final bool showIcon;
  final TextStyle? buttonTextStyle;

  const TitleWithOptionalButton({
    super.key,
    required this.title,
    this.showButton = true,
    this.buttonText = 'See All',
    this.buttonIcon = Icons.arrow_forward_ios_rounded,
    this.onTap,
    this.buttonColor,
    this.showIcon = true,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showButton)
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    buttonText,
                    style:
                        buttonTextStyle ??
                        const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                  ),
                  if (showIcon)
                    Icon(buttonIcon, size: 16, color: Colors.black54),
                  if (showIcon) 6.spaceX,
                ],
              ),
            ),
          ),
      ],
    );
  }
}
