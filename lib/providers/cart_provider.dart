import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

/// Model representing a single cart item
class CartItem {
  final int id;
  final int quantity;

  const CartItem({required this.id, this.quantity = 1});

  /// Returns a copy of the CartItem with updated values
  CartItem copyWith({int? id, int? quantity}) {
    return CartItem(id: id ?? this.id, quantity: quantity ?? this.quantity);
  }

  /// Creates a CartItem object from a map (used when reading from Hive)
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(id: map['id'] as int, quantity: map['quantity'] as int);
  }

  /// Converts a CartItem object to a map (used when writing to Hive)
  Map<String, dynamic> toMap() {
    return {'id': id, 'quantity': quantity};
  }
}

/// Riverpod provider for accessing CartNotifier state
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

/// StateNotifier to manage cart items and persist them in Hive
class CartNotifier extends StateNotifier<List<CartItem>> {
  static const String _cartBoxName = "CART_BOX"; // Hive box name
  static const String _cartKey = "cart_items"; // Hive key inside the box

  late Box _cartBox; // Hive box reference

  /// Constructor that initializes the cart state from Hive
  CartNotifier() : super([]) {
    _init();
  }

  /// Loads stored cart data from Hive and updates the state
  Future<void> _init() async {
    _cartBox = Hive.box(_cartBoxName); // Access the Hive box

    final storedItems = _cartBox.get(_cartKey); // Get saved list of items

    if (storedItems != null && storedItems is List) {
      final cartItems = storedItems
          .whereType<Map>() // Only allow map entries
          .map((item) => CartItem.fromMap(Map<String, dynamic>.from(item)))
          .toList();

      state = cartItems; // Update Riverpod state with stored cart
    }
  }

  /// Saves the current state to Hive
  Future<void> _saveToHive() async {
    final itemList = state.map((item) => item.toMap()).toList();
    await _cartBox.put(_cartKey, itemList); // Store list of maps
  }

  /// Adds an item to the cart, or increases its quantity if already present
  void addItem(int productId) {
    final index = state.indexWhere((item) => item.id == productId);

    if (index != -1) {
      // Item already in cart, increase quantity
      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity + 1,
      );

      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else {
      // Item not in cart, add it with quantity 1
      state = [...state, CartItem(id: productId)];
    }

    _saveToHive(); // save changes
  }

  /// Decreases quantity of an item or removes it if quantity is 1
  void decreaseItem(int productId) {
    final index = state.indexWhere((item) => item.id == productId);

    if (index != -1) {
      final currentItem = state[index];

      if (currentItem.quantity > 1) {
        // Decrease quantity
        final updatedItem = currentItem.copyWith(
          quantity: currentItem.quantity - 1,
        );

        state = [
          ...state.sublist(0, index),
          updatedItem,
          ...state.sublist(index + 1),
        ];
      } else {
        // Remove item if quantity reaches 0
        removeItem(productId);
      }

      _saveToHive(); // save changes
    }
  }

  /// Removes an item from the cart completely
  void removeItem(int productId) {
    state = state.where((item) => item.id != productId).toList();
    _saveToHive(); // save changes
  }

  /// Gets the quantity of a product in the cart
  int getQuantity(int productId) {
    return state
        .firstWhere(
          (item) => item.id == productId,
          orElse: () => const CartItem(id: -1, quantity: 0),
        )
        .quantity;
  }

  /// Calculates the total number of items (not products) in the cart
  int get totalItems {
    return state.fold(0, (total, item) => total + item.quantity);
  }

  /// Clears the entire cart
  void clearCart() {
    state = [];
    _saveToHive(); // save changes
  }

  /// Optional Reload the cart state from Hive manually
  void reloadCart() {
    _init(); // Refetch from Hive and update state
  }
}
