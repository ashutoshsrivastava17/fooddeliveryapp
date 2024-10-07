import 'menu_item.dart';
import 'nutrition.dart';

class CartItem extends MenuItem {
  int? quantity;

  // Default cart_item.dart constructor
  CartItem({
    super.id,
    super.name,
    super.shortDesc,
    super.longDesc,
    super.nutritions,
    super.price,
    super.imageUrl,
    this.quantity,
  });

  // Factory method to create a cart_item.dart from MenuItem and quantity
  factory CartItem.fromMenuItem(MenuItem menuItem, int quantity) {
    return CartItem(
      id: menuItem.id,
      name: menuItem.name,
      shortDesc: menuItem.shortDesc,
      longDesc: menuItem.longDesc,
      nutritions: menuItem.nutritions,
      price: menuItem.price,
      imageUrl: menuItem.imageUrl,
      quantity: quantity,
    );
  }

  // copyWith method to allow modification of individual properties
  CartItem copyWith({
    int? id,
    String? name,
    String? shortDesc,
    String? longDesc,
    List<Nutrition>? nutritions,
    String? price,
    String? imageUrl,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      // Use provided id, or fallback to current id
      name: name ?? this.name,
      shortDesc: shortDesc ?? this.shortDesc,
      longDesc: longDesc ?? this.longDesc,
      nutritions: nutritions ?? this.nutritions,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ??
          this.quantity, // Use provided quantity, or fallback to current quantity
    );
  }

  // Factory constructor to create from JSON
  CartItem.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    quantity = json['quantity'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['quantity'] = quantity;
    return data;
  }
}
