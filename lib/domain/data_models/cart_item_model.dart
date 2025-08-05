import 'package:hive/hive.dart';

// part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int quantity;

  CartItemModel({required this.id, this.quantity = 1});

  CartItemModel copyWith({int? id, int? quantity}) {
    return CartItemModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
    );
  }
}
