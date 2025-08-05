import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class CartItem {
  final int id;
  final int quantity;

  const CartItem({required this.id, this.quantity = 1});

  CartItem copyWith({int? id, int? quantity}) {
    return CartItem(id: id ?? this.id, quantity: quantity ?? this.quantity);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);
  final _cartBoxName = Hive.box("CART_BOX");
  void addItem(int productId) async {
    await _cartBoxName.add("CART_BOX");
    print("added to the database");

    final index = state.indexWhere((item) => item.id == productId);
    if (index != -1) {
      // Create a new CartItem with increased quantity
      final updatedItem = CartItem(
        id: state[index].id,
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
  }

  void decreaseItem(int productId) {
    final index = state.indexWhere((item) => item.id == productId);
    if (index != -1) {
      final currentItem = state[index];
      if (currentItem.quantity > 1) {
        // Decrease quantity
        final updatedItem = CartItem(
          id: currentItem.id,
          quantity: currentItem.quantity - 1,
        );
        state = [
          ...state.sublist(0, index),
          updatedItem,
          ...state.sublist(index + 1), // This was missing!
        ];
      } else {
        // Remove item if quantity is 1 or less
        removeItem(productId);
      }
    }
  }

  void removeItem(int productId) {
    state = state.where((item) => item.id != productId).toList();
  }

  int getQuantity(int productId) {
    return state.firstWhere((item) {
      return item.id == productId;
    }, orElse: () => CartItem(id: productId, quantity: 0)).quantity;
  }

  // Get total number of items in cart (sum of all quantities)
  int get totalItems {
    return state.fold(0, (total, item) => total + item.quantity);
  }

  void clearCart() {
    state = [];
  }
}
