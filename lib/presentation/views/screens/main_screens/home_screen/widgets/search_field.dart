import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final Widget? trailing;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTrailingTap;
  final bool showSearchButton;
  final Color searchButtonColor;

  const CustomSearchField({
    super.key,
    this.hintText = 'Search',
    this.trailing,
    this.controller,
    this.onChanged,
    this.onTrailingTap,
    this.showSearchButton = false,
    this.searchButtonColor = const Color(0xFFFFD700),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          // Search Icon
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.search, color: Colors.black54, size: 20),
          ),

          // Search TextField
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),

          // Search Button or Trailing Widget
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: showSearchButton
                ? GestureDetector(
                    onTap: onTrailingTap,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: searchButtonColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                : trailing != null
                ? GestureDetector(onTap: onTrailingTap, child: trailing)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
