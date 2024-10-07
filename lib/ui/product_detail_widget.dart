import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/models/cart_item.dart';
import 'package:fooddeliveryapp/models/menu_item.dart';
import 'package:fooddeliveryapp/models/nutrition.dart';
import 'package:fooddeliveryapp/repository/cart_repository.dart';
import 'package:fooddeliveryapp/utils/data_extensions.dart';
import 'package:fooddeliveryapp/widgets/custom_background.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class ProductDetailWidget extends StatefulWidget {
  final MenuItem menuItem;

  const ProductDetailWidget({
    super.key,
    required this.menuItem,
  });

  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetailWidget> {
  int _productCount = 1;

  @override
  Widget build(BuildContext context) {
    final menuItem = widget.menuItem;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(menuItem.imageUrl ?? ""),
          _buildProductName(menuItem.name ?? "").addMarginSymmetric(
              vertical: 16),
          _buildProductLongDesc(menuItem.longDesc ?? ""),
          _buildProductKcal(menuItem.nutritions).addMarginSymmetric(vertical: 24),
          _buildAddInPoke(),
          _buildAddActions(context, menuItem).addMarginLTRB(top: 24),
        ],
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Center(child: Image.network(imageUrl, width: 300));
  }

  Widget _buildProductName(String productName) {
    return Text(
      productName,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildProductLongDesc(String longDesc) {
    return Text(
      longDesc,
      style: const TextStyle(
        color: filterBackground,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildProductKcal(List<Nutrition>? nutritions) {
    if (nutritions == null || nutritions.isEmpty) return const SizedBox();

    return CustomBackground(
        cornerRadius: 16,
        backgroundColor: Colors.transparent,
        borderColor: filterBackground.withAlpha(50),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: nutritions
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final nutrition = entry.value;
            return _buildProductEnergy(
                index == 0, index == nutritions.length - 1, nutrition);
          }).toList(),
        )
    );
  }

  Widget _buildProductEnergy(bool isFirst, bool isLast, Nutrition nutrition) {
    return Padding(
      padding: EdgeInsets.fromLTRB(isFirst ? 16 : 8, 12, isLast ? 16 : 8, 12),
      child: Column(
        children: [
          Text(
            nutrition.value ?? "",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            nutrition.unit ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: filterBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddInPoke() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(
          "Add in Poke",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        Icon(Icons.arrow_forward_ios, size: 16),
      ],
    );
  }

  Widget _buildAddActions(BuildContext context, MenuItem menuItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIncrementQuantity(),
        _buildAddToCartButton(context, menuItem).addMarginLTRB(left: 8),
      ],
    );
  }

  Widget _buildIncrementQuantity() {
    return CustomBackground(
      cornerRadius: 8,
      height: 50,
      backgroundColor: filterBackground,
      child: Row(
        children: [
          _buildQuantityButton(
            icon: Icons.remove,
            onTap: () =>
                setState(() {
                  if (_productCount > 1) _productCount--;
                }),
            isDisabled: _productCount == 1,
          ).addMarginLTRB(left: 12),
          Text(
            "$_productCount",
            style: const TextStyle(fontSize: 18),
          ).addMarginSymmetric(horizontal: 16),
          _buildQuantityButton(
            icon: Icons.add,
            onTap: () =>
                setState(() {
                  if (_productCount < maxProductQty) _productCount++;
                }),
          ).addMarginLTRB(right: 12),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isDisabled = false,
  }) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Icon(
          icon,
          color: isDisabled ? Colors.black45 : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, MenuItem menuItem) {
    return InkWell(
      onTap: () {
        CartRepository.addToCart(
            CartItem.fromMenuItem(menuItem, _productCount));
        Navigator.pop(context);
      },
      child: CustomBackground(
        cornerRadius: 8,
        height: 50,
        child: Row(
          children: [
            const Text(
              "Add to cart",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ).addMarginLTRB(left: 12, right: 8),
            Text(
              "${_productCount* (double.parse( menuItem.price??"0"))}".getDisplayPrice(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ).addMarginLTRB(right: 12),
          ],
        ),
      ),
    );
  }
}
