import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/models/cart_item.dart';
import 'package:fooddeliveryapp/repository/cart_repository.dart';
import 'package:fooddeliveryapp/widgets/circular_dot.dart';
import 'package:fooddeliveryapp/widgets/custom_background.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/data_extensions.dart';

// This widget represents the detailed view of the shopping cart
class CartDetailWidget extends StatefulWidget {
  const CartDetailWidget({super.key});

  @override
  CartState createState() => CartState();
}

class CartState extends State<CartDetailWidget> {
  int _cutlery = 1; // Initialize cutlery count

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader().addMarginLTRB(top: 16, bottom: 16),
          // Header showing delivery info
          _buildProductDetails(),
          // List of cart items
          _buildCutlerySection(),
          // Cutlery selection
          _buildDeliverySection().addMarginLTRB(top: 16),
          // Delivery information
          _buildPaymentMethod().addMarginLTRB(top: 36),
          // Payment method selection
        ],
      ).addMarginAll(24), // Outer margin for the entire column
    );
  }

  // Builds the header displaying delivery information
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "We deliver in\n24 minutes to the address:",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
        ),
        Row(
          children: [
            const Text(
              "100a Ealing Rd",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text(
              "Change address",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: filterBackground),
            ).addMarginLTRB(left: 16),
          ],
        ).addMarginLTRB(top: 16),
      ],
    );
  }

  // Builds the list of product details in the cart
  Widget _buildProductDetails() {
    List<CartItem> cartItems =
        CartRepository.getCartItems(); // Fetch cart items
    return ListView.builder(
      shrinkWrap: true, // Prevents scrolling issues
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildProductItem(cartItems[index], index); // Build each item
      },
    );
  }

  // Builds individual product item details
  Widget _buildProductItem(CartItem cartItem, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(cartItem.imageUrl), // Product image
        _buildProductDetailsColumn(cartItem, index)
            .addMarginSymmetric(horizontal: 18)
            .expandBy(3), // Product details
        _buildProductPrice(cartItem).expandBy(0), // Product price
      ],
    ).addPaddingSymmetric(vertical: 16);
  }

  // Builds the product image widget
  Widget _buildProductImage(String? imageUrl) {
    return Image.network(
      imageUrl ?? "",
      width: 90,
    ); // Network image
  }

  // Builds the column for product details (name and quantity control)
  Widget _buildProductDetailsColumn(CartItem cartItem, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(cartItem.name ?? "", style: const TextStyle(fontSize: 20)),
        _buildQuantityControl(cartItem, index).addMarginLTRB(top: 16),
        // Quantity control
      ],
    );
  }

  // Builds the quantity control for each product
  Widget _buildQuantityControl(CartItem cartItem, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildQuantityButton(
          Icons.remove,
          () {
            setState(() {
              if (cartItem.quantity != 1) {
                cartItem.quantity =
                    (cartItem.quantity ?? 1) - 1; // Decrease quantity
                CartRepository.updateAtIndex(
                    index, cartItem); // Update repository
              } else {
                CartRepository.removeFromCart(cartItem);
                if (CartRepository.isCartEmpty()) Navigator.pop(context);
              }
            });
          },
          cartItem.quantity == 1
              ? CartRepository.getCartItems().length == 1
                  ? Colors.red
                  : Colors.black45
              : Colors.black87,
        ),
        Text("${cartItem.quantity ?? 1}", style: const TextStyle(fontSize: 18))
            .addMarginSymmetric(horizontal: 12),
        _buildQuantityButton(
          Icons.add,
          () {
            if (cartItem.quantity != maxProductQty) {
              setState(() {
                cartItem.quantity =
                    (cartItem.quantity ?? 0) + 1; // Increase quantity
                CartRepository.updateAtIndex(
                    index, cartItem); // Update repository
              });
            }
          },
          Colors.black87,
        ),
      ],
    );
  }

  // Builds a button for adjusting quantity
  Widget _buildQuantityButton(
      IconData icon, VoidCallback onPressed, Color iconColor) {
    return InkWell(
      onTap: onPressed,
      child: CustomBackground(
        cornerRadius: 10,
        backgroundColor: filterBackground,
        child: Icon(icon, color: iconColor).addPaddingAll(5),
      ),
    );
  }

  // Builds the product price display
  Widget _buildProductPrice(CartItem cartItem) {
    return Text(
      "${(cartItem.quantity ?? 0) * double.parse(cartItem.price ?? "0")}"
          .getDisplayPrice(), // Calculate total price for the item
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  // Builds the cutlery section
  Widget _buildCutlerySection() {
    return Column(
      children: [
        const Divider(color: Colors.black12), // Divider for visual separation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.restaurant),
            const Text("Cutlery", style: TextStyle(fontSize: 20)),
            _buildCutleryControl(), // Control for cutlery quantity
          ],
        ).addMarginSymmetric(vertical: 24),
        const Divider(color: Colors.black12),
      ],
    );
  }

  // Builds the cutlery quantity control
  Widget _buildCutleryControl() {
    return Row(
      children: [
        _buildQuantityButton(
          Icons.remove,
          () {
            setState(() {
              if (_cutlery != 1) _cutlery--; // Decrease cutlery count
            });
          },
          _cutlery == 1 ? Colors.black38 : Colors.black87,
        ),
        Text("$_cutlery", style: const TextStyle(fontSize: 18))
            .addMarginSymmetric(horizontal: 12),
        _buildQuantityButton(
          Icons.add,
          () {
            if (_cutlery != maxCutleryQty) {
              setState(() {
                _cutlery++; // Increase cutlery count
              });
            }
          },
          Colors.black87,
        ),
      ],
    );
  }

  // Builds the delivery information section
  Widget _buildDeliverySection() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Delivery", style: TextStyle(fontSize: 20)),
            Text("Free delivery from \$30",
                style: TextStyle(fontSize: 16, color: filterBackground)),
          ],
        ),
        Text("\$0.0",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        // Display delivery fee
      ],
    );
  }

  // Builds the payment method section
  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Payment method",
            style: TextStyle(fontSize: 16, color: filterBackground)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _applePayWidget(),
            // Apple Pay option
            const Icon(Icons.arrow_forward_ios, size: 16),
            // Arrow for navigation
          ],
        ).addMarginLTRB(top: 24, bottom: 36),
        _buildCartSummary(), // Summary of the cart
      ],
    );
  }

  // Builds the cart summary at the bottom
  Widget _buildCartSummary() {
    return CustomBackground(
      cornerRadius: 16,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Cart",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          // Cart label
          Row(
            children: [
              // Estimated time
              const Text("24 min",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              // Dot indicator
              const CircleDot(diameter: 5).addMarginSymmetric(horizontal: 8),
              // Total price
              Text(CartRepository.getTotalPrice().getDisplayPrice(),
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ],
      ).addPaddingSymmetric(horizontal: 20),
    );
  }

  // Widget for Apple Pay option
  Widget _applePayWidget() {
    return Row(
      children: [
        CustomBackground(
          width: 50,
          height: 25,
          cornerRadius: 4,
          borderColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Row(
            children: [
              Icon(Icons.apple, size: 16),
              Text("Pay"),
            ],
          ).addPaddingSymmetric(horizontal: 4),
        ),
        const Text("Apple Pay",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18))
            .addMarginLTRB(left: 16),
      ],
    );
  }
}
