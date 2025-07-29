// ignore_for_file: unused_import

import 'dart:io';

import '../../shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigation extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const CustomBottomNavigation({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isIOS ? 99 : 90,
      padding: EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      color: context.theme.scaffoldBackgroundColor,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.black,

        selectedItemColor: AppColors.black,
        selectedLabelStyle: AppTextstyle.bodyTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: AppTextstyle.bodyTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: [
          bottomNavigationBarItem(
            AppAssets.home,
            'home',
            currentIndex == 0,
            context.theme.bottomNavigationBarTheme,
          ),
          bottomNavigationBarItem(
            AppAssets.shop,
            'Shop',
            currentIndex == 1,
            context.theme.bottomNavigationBarTheme,
          ),
          bottomNavigationBarItem(
            AppAssets.wishlist,
            'Wishlist',
            currentIndex == 2,
            context.theme.bottomNavigationBarTheme,
          ),
          bottomNavigationBarItem(
            AppAssets.chart,
            'chart',
            currentIndex == 3,
            context.theme.bottomNavigationBarTheme,
          ),
          bottomNavigationBarItem(
            AppAssets.profile,
            'profile',
            currentIndex == 4,
            context.theme.bottomNavigationBarTheme,
          ),
        ],
      ),
    );
  }
}

BottomNavigationBarItem bottomNavigationBarItem(
  String asset,
  String label,
  bool isActive,
  BottomNavigationBarThemeData theme,
) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      asset,
      height: 26,
      width: 26,
      colorFilter: ColorFilter.mode(
        isActive ? Colors.black : Colors.grey,
        BlendMode.srcIn,
      ),
    ),
    label: getTranslated(label, appContext),
  );
}
