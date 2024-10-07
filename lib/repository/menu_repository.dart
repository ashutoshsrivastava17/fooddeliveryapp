import 'package:fooddeliveryapp/models/menu_item.dart';
import 'package:fooddeliveryapp/models/nutrition.dart';

class MenuRepository {
  // Returns a list of menu items available in the application
  static List<MenuItem> getMenuItems() {
    return [
      MenuItem(
        id: 1,
        name: "Veggie Delight Sandwich",
        shortDesc: "Two Slices of Bread with Fresh Veggies",
        longDesc:
        "Savor the fresh flavors of our Veggie Delight Sandwich, featuring crisp vegetables nestled between two slices of soft bread.",
        nutritions: [
          Nutrition(value: "250", unit: "kCal"),
          Nutrition(value: "300", unit: "grams"),
          Nutrition(value: "8", unit: "protein"),
          Nutrition(value: "4", unit: "fat"),
          Nutrition(value: "45", unit: "carbs")
        ],
        price: "8.50",
        imageUrl:
        "https://purepng.com/public/uploads/large/purepng.com-food-plate-top-viewfood-objects-plate-941524640234gz2of.png",
      ),
      MenuItem(
        id: 2,
        name: "Protein-Packed Salad",
        shortDesc: "Protein-Packed Salad with Eggs, Cheese, and Chicken",
        longDesc:
        "This hearty salad is packed with protein, combining flavorful eggs, rich cheese, and tender chicken for a satisfying meal.",
        nutritions: [
          Nutrition(value: "450", unit: "kCal"),
          Nutrition(value: "350", unit: "grams"),
          Nutrition(value: "35", unit: "protein"),
          Nutrition(value: "25", unit: "fat"),
          Nutrition(value: "12", unit: "carbs")
        ],
        price: "10.75",
        imageUrl:
        "https://static.vecteezy.com/system/resources/thumbnails/030/724/579/small_2x/a-plate-with-an-egg-salmon-and-avocado-ai-generative-free-png.png",
      ),
      MenuItem(
        id: 3,
        name: "Energizing Salad",
        shortDesc: "Energizing Salad with Lettuce, Corn, and Spinach",
        longDesc:
        "Revitalize your day with this energizing salad, featuring crisp lettuce, sweet corn, and fresh spinach, perfect for a light meal.",
        nutritions: [
          Nutrition(value: "200", unit: "kCal"),
          Nutrition(value: "250", unit: "grams"),
          Nutrition(value: "5", unit: "protein"),
          Nutrition(value: "10", unit: "fat"),
          Nutrition(value: "30", unit: "carbs")
        ],
        price: "9.00",
        imageUrl:
        "https://static.vecteezy.com/system/resources/thumbnails/037/799/109/small_2x/bowl-of-salad-in-black-bowl-top-view-isolated-on-transparent-background-png.png",
      ),
      MenuItem(
        id: 4,
        name: "Fresh Spinach Salad",
        shortDesc: "Energizing Salad with Lettuce, Corn, and Spinach",
        longDesc:
        "This vibrant salad combines fresh spinach with crispy lettuce and sweet corn, offering a refreshing and nutritious option.",
        nutritions: [
          Nutrition(value: "220", unit: "kCal"),
          Nutrition(value: "270", unit: "grams"),
          Nutrition(value: "6", unit: "protein"),
          Nutrition(value: "11", unit: "fat"),
          Nutrition(value: "33", unit: "carbs")
        ],
        price: "9.00",
        imageUrl: "https://espressofoods.in/images/Cobb-Salad.png",
      ),
      MenuItem(
        id: 5,
        name: "Creamy Dal Makhni",
        shortDesc: "Creamy Dal Makhni, buttery tomato gravy.",
        longDesc:
        "Indulge in our creamy Dal Makhni, featuring slow-cooked black lentils enveloped in a rich, buttery tomato gravy that melts in your mouth.",
        nutritions: [
          Nutrition(value: "320", unit: "kCal"),
          Nutrition(value: "300", unit: "grams"),
          Nutrition(value: "12", unit: "protein"),
          Nutrition(value: "18", unit: "fat"),
          Nutrition(value: "35", unit: "carbs")
        ],
        price: "11.50",
        imageUrl:
        "https://cdn.prod.website-files.com/6305f7d600c9842969920a58/63c77da0f8d46e408020c722_7XBx0QpIDsoGArKqQCkSclQY_I-_YpziWKe1x2LCnHI.png",
      ),
    ];
  }

  // Returns a list of filter options for the home page
  static List<String> getHomeFilters() {
    return ["", "Salads", "Pizza", "Beverages", "Snacks"];
  }
}