import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/wishlist_screen/widgets/wishlist_bottom_row.dart';
import 'package:shopping_app/shared/app_persistance/app_local.dart';
import 'package:shopping_app/shared/app_snack_bar.dart';
import 'package:shopping_app/shared/constants/app_local_keys.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Widget image;
  final String productName;
  final int price;
  final VoidCallback? onAddToCart;
  final VoidCallback? onDecreaseCart;
  final VoidCallback? onRemoveFromCart;

  final VoidCallback? onTap;
  final bool isCartHighlighted;
  final bool isWishlistScreen;

  const ProductCard({
    super.key,
    required this.image,
    required this.productName,
    required this.price,
    this.onAddToCart,
    this.onDecreaseCart,
    this.onRemoveFromCart,
    this.onTap,
    this.isCartHighlighted = false,
    this.isWishlistScreen = false,
  });

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  bool isFavorited = false;
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image + Favorite icon
            Container(
              height: 130,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(height: 100, child: widget.image),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                      },
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.black,
                        size: 27,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product name and dynamic bottom content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  3.spaceY,
                  widget.isWishlistScreen
                      ? WishListScreenBottomContent()
                      : _defaultBottomContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // default cart content
  Widget _defaultBottomContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //price
        Text(
          "\$${widget.price}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        //quantity control
        quantity == 0
            ? GestureDetector(
                onTap: () {
                  print("added to cart");

                  ///snackbar to show item added to the cart
                  AppSnackBar.showSnackBar(
                    '${widget.productName} added to cart',
                    context: context,
                  );

                  setState(() {
                    quantity = 1;
                  });
                  widget.onAddToCart?.call();
                },
                // add to cart button
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: widget.isCartHighlighted
                        ? const Color(0xFFFFD700)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: widget.isCartHighlighted ? 0 : 1,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final productList = await AppLocal.ins.cartBox.get(
                        AppLocalKeys.product,
                      );
                      // if (productList == null || productList.isEmpty) {
                      //   AppLocal.ins.cartBox.put(AppLocalKeys.product, [
                      //     {
                      //       // "id": widget.productId,
                      //       "name": widget.productName,
                      //       // "price": widget.price,
                      //       // "image": widget.image,
                      //       // "quantity": quantity,
                      //     },
                      //   ]);
                      // } else {}

                      AppLocal.ins.cartBox.put(AppLocalKeys.product, [
                        {
                          // "id": widget.productId,
                          "name": widget.productName,
                          // "price": widget.price,
                          // "image": widget.image,
                          // "quantity": quantity,
                        },
                      ]);
                      setState(() {
                        quantity++;
                      });
                      print("$quantity added to cart");
                      widget.onAddToCart?.call();
                    },
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (quantity > 0) {
                        setState(() {
                          quantity--;
                        });
                        widget.onDecreaseCart?.call();
                        // widget.onRemoveFromCart?.call();
                      } else {
                        setState(() {
                          quantity = 0;
                        });
                        widget.onRemoveFromCart?.call();
                        print("remove from cart");
                        AppSnackBar.showSnackBar(
                          '${widget.productName} removed from cart',
                          context: context,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                  //display quantity
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                      print("$quantity added to cart");
                      widget.onAddToCart?.call();
                    },
                    child: const Icon(Icons.add, size: 20, color: Colors.green),
                  ),
                ],
              ),
      ],
    );
  }
}
