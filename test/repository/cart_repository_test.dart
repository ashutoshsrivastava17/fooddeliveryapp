import 'package:flutter_test/flutter_test.dart';
import 'package:fooddeliveryapp/models/cart_item.dart';
import 'package:fooddeliveryapp/repository/cart_repository.dart';

void main() {
  group('CartRepository Tests', () {
    setUp(() {
      CartRepository.getCartItems().clear(); // Clear cart before each test
    });

    test('Add a new item to the cart', () {
      CartItem item = CartItem(id: 1, name: 'Burger', price: '5.00', quantity: 1);
      CartRepository.addToCart(item);

      List<CartItem> cartItems = CartRepository.getCartItems();
      expect(cartItems.length, 1);
      expect(cartItems[0].name, 'Burger');
    });

    test('Increase quantity if item already exists in the cart', () {
      CartItem item1 = CartItem(id: 1, name: 'Burger', price: '5.00', quantity: 1);
      CartRepository.addToCart(item1);

      CartItem item2 = CartItem(id: 1, name: 'Burger', price: '5.00', quantity: 2);
      CartRepository.addToCart(item2);

      List<CartItem> cartItems = CartRepository.getCartItems();
      expect(cartItems.length, 1);
      expect(cartItems[0].quantity, 3); // 1 + 2 = 3
    });

    test('Remove an item from the cart', () {
      CartItem item = CartItem(id: 1, name: 'Burger', price: '5.00', quantity: 1);
      CartRepository.addToCart(item);

      CartRepository.removeFromCart(item);

      List<CartItem> cartItems = CartRepository.getCartItems();
      expect(cartItems.length, 0);
    });

    test('Check if cart is empty', () {
      expect(CartRepository.isCartEmpty(), true);

      CartItem item = CartItem(id: 1, name: 'Burger', price: '5.00', quantity: 1);
      CartRepository.addToCart(item);

      expect(CartRepository.isCartEmpty(), false);
    });

    test('Calculate total price', () {
      CartItem item1 = CartItem(id: 1, name: 'Burger', price: '5.00', quantity: 2);
      CartItem item2 = CartItem(id: 2, name: 'Pizza', price: '10.00', quantity: 1);

      CartRepository.addToCart(item1);
      CartRepository.addToCart(item2);

      String totalPrice = CartRepository.getTotalPrice();
      expect(totalPrice, '20.00'); // (2 * 5.00) + (1 * 10.00)
    });

    test('Update item in the cart', () {
      CartItem item = CartItem(id: 1, name: 'Burger', price: '5.00', quantity: 1);
      CartRepository.addToCart(item);

      CartItem updatedItem = CartItem(id: 1, name: 'Burger Deluxe', price: '7.00', quantity: 2);
      CartRepository.updateAtIndex(0, updatedItem);

      List<CartItem> cartItems = CartRepository.getCartItems();
      expect(cartItems.length, 1);
      expect(cartItems[0].name, 'Burger Deluxe');
      expect(cartItems[0].price, '7.00');
      expect(cartItems[0].quantity, 2);
    });
  });
}
