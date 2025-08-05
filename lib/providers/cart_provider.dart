import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class CartItem {
  final int id;
  final int quantity;

  const CartItem({required this.id, this.quantity = 1});

  CartItem copyWith({int? id, int? quantity}) {
    return CartItem(id: id ?? this.id, quantity: quantity ?? this.quantity);
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(id: map['id'] as int, quantity: map['quantity'] as int);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'quantity': quantity};
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  static const String _cartBoxName = "CART_BOX";
  static const String _cartKey = "cart_items";

  late Box _cartBox;

  CartNotifier() : super([]) {
    _init();
  }

  Future<void> _init() async {
    _cartBox = Hive.box(_cartBoxName);
    final storedItems = _cartBox.get(_cartKey);

    if (storedItems != null && storedItems is List) {
      final cartItems = storedItems
          .whereType<Map>()
          .map((item) => CartItem.fromMap(Map<String, dynamic>.from(item)))
          .toList();
      state = cartItems;
    }
  }

  Future<void> _saveToHive() async {
    final itemList = state.map((item) => item.toMap()).toList();
    await _cartBox.put(_cartKey, itemList);
  }

  void addItem(int productId) {
    final index = state.indexWhere((item) => item.id == productId);

    if (index != -1) {
      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity + 1,
      );
      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else {
      state = [...state, CartItem(id: productId)];
    }

    _saveToHive();
  }

  void decreaseItem(int productId) {
    final index = state.indexWhere((item) => item.id == productId);
    if (index != -1) {
      final currentItem = state[index];
      if (currentItem.quantity > 1) {
        final updatedItem = currentItem.copyWith(
          quantity: currentItem.quantity - 1,
        );
        state = [
          ...state.sublist(0, index),
          updatedItem,
          ...state.sublist(index + 1),
        ];
      } else {
        removeItem(productId);
      }
      _saveToHive();
    }
  }

  void removeItem(int productId) {
    state = state.where((item) => item.id != productId).toList();
    _saveToHive();
  }

  int getQuantity(int productId) {
    return state
        .firstWhere(
          (item) => item.id == productId,
          orElse: () => const CartItem(id: -1, quantity: 0),
        )
        .quantity;
  }

  int get totalItems {
    return state.fold(0, (total, item) => total + item.quantity);
  }

  void clearCart() {
    state = [];
    _saveToHive();
  }

  // Optionally: reload from Hive
  void reloadCart() {
    _init();
  }
}
