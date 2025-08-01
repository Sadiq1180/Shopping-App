import 'package:flutter/material.dart';
import 'package:shopping_app/shared/extensions/sized_box.dart';

class ProductCard extends StatefulWidget {
  final Widget image;
  final String productName;
  final int price;
  final VoidCallback? onAddToCart;
  final VoidCallback? onTap;
  final bool isCartHighlighted;
  final bool isWishlistScreen;

  const ProductCard({
    super.key,
    required this.image,
    required this.productName,
    required this.price,
    this.onAddToCart,
    this.onTap,
    this.isCartHighlighted = false,
    this.isWishlistScreen = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorited = false;

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
                      ? _wishListScreenContent()
                      : _defaultBottomContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultBottomContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$${widget.price}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: widget.onAddToCart,
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
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _wishListScreenContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.star, size: 16, color: Colors.orange),
            SizedBox(width: 4),
            Text("4.5 (235)", style: TextStyle(fontSize: 12)),
          ],
        ),
        Text(
          "\$200",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
