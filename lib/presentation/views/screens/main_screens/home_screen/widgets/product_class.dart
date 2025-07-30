class Product {
  final String image;
  final String name;
  final double price;
  final double? rating;
  final int? reviewCount;
  final bool isFavorite;
  final bool isCartHighlighted;

  Product({
    required this.image,
    required this.name,
    required this.price,
    this.rating,
    this.reviewCount,
    this.isFavorite = false,
    this.isCartHighlighted = false,
  });
}
