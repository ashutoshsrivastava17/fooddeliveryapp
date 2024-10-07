import 'nutrition.dart';
class MenuItem {
  int? id;
  String? name;
  String? shortDesc;
  String? longDesc;
  List<Nutrition>? nutritions; // Replaced kCal with nutritions
  String? price;
  String? imageUrl;

  MenuItem({
    this.id,
    this.name,
    this.shortDesc,
    this.longDesc,
    this.nutritions, // Corrected from kCal to nutritions
    this.price,
    this.imageUrl,
  });

  MenuItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDesc = json['shortDesc'];
    longDesc = json['longDesc'];
    if (json['nutritions'] != null) {
      nutritions = <Nutrition>[]; // Initialize as an empty list
      json['nutritions'].forEach((v) {
        nutritions!.add(Nutrition.fromJson(v));
      });
    }
    price = json['price'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortDesc'] = shortDesc;
    data['longDesc'] = longDesc;
    if (nutritions != null) {
      data['nutritions'] = nutritions!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
