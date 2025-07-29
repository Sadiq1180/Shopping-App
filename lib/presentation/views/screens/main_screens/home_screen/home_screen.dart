import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/base_widgets/keyboard_aware.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/banner.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/product_card.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/search_field.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/section_header.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/title_with_button.dart';
import 'package:shopping_app/shared/constants/app_assets.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SSenseHeader(),
      body: KeyboardAware(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.spaceY,
                //Searc field
                CustomSearchField(
                  trailing: Icon(Icons.search),
                  searchButtonColor: Colors.amber,
                  showSearchButton: true,
                ),
                20.spaceY,

                ///Banner
                PromotionalBanner(),
                30.spaceY,

                ///title with button
                TitleWithOptionalButton(title: "Recommended Styles"),
                20.spaceY,

                ///product vertical Card
                ProductCard(
                  image: AppAssets.person3,
                  productName: "Dries Van Noten",
                  price: "\$500",
                  isCartHighlighted: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
