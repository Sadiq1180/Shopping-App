import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final int id;
  int quantity;

  CartItem({required this.id, this.quantity = 1});
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(int productId) {
    final index = state.indexWhere((item) => item.id == productId);
    if (index != -1) {
      state[index].quantity++;
    } else {
      state = [...state, CartItem(id: productId)];
    }
    state = [...state];
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
          //  ...state.sublist(index + 1),
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

  void clearCart() {
    state = [];
  }
}
