import 'package:fooddeliveryapp/models/cart_item.dart';

class CartRepository {
  static final List<CartItem> _cartItems = [];

  // Adds a CartItem to the cart or increases the quantity if it already exists
  static void addToCart(CartItem cartItem) {
    // Check if the item is already in the cart based on a unique identifier (e.g., id or name)
    int existingIndex = _cartItems.indexWhere((item) => item.id == cartItem.id);

    if (existingIndex != -1) {
      // If the item exists, increase its quantity
      CartItem existingItem = _cartItems[existingIndex];
      int updatedQuantity =
          (existingItem.quantity ?? 1) + (cartItem.quantity ?? 1);
      _cartItems[existingIndex] =
          existingItem.copyWith(quantity: updatedQuantity);
    } else {
      // If the item doesn't exist, add it to the cart
      _cartItems.add(cartItem);
    }
  }

  // Returns the current list of CartItems in the cart
  static List<CartItem> getCartItems() {
    return _cartItems;
  }

  // Updates a CartItem at a specific index
  static void updateAtIndex(int index, CartItem cartItem) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index] = cartItem;
    }
  }

  // Checks if the cart is empty
  static bool isCartEmpty() {
    return _cartItems.isEmpty;
  }

  // Removes a CartItem from the cart
  static void removeFromCart(CartItem cartItem) {
    _cartItems.removeWhere((item) => item.id == cartItem.id);
  }

  // Calculates the total price of all items in the cart
  static String getTotalPrice() {
    double totalPrice = 0;
    for (var item in _cartItems) {
      totalPrice += (item.quantity ?? 1) * double.parse(item.price ?? "0.0");
    }
    return totalPrice.toStringAsFixed(2); // Format to 2 decimal places
  }

  static void clearCart() {
    _cartItems.clear();
  }
}
