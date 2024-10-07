import 'package:flutter_test/flutter_test.dart';
import 'package:fooddeliveryapp/models/menu_item.dart';
import 'package:fooddeliveryapp/repository/menu_repository.dart';

void main() {
  test('Get list of menu items', () {
    List<MenuItem> menuItems = MenuRepository.getMenuItems();

    // Check that the number of items returned is correct
    expect(menuItems.length, 5);

    // Check that the first item matches expected values
    expect(menuItems[0].name, "Veggie Delight Sandwich");
    expect(menuItems[0].price, "8.50");
    expect(menuItems[0].nutritions![0].value, "250");
    expect(menuItems[0].nutritions![0].unit, "kCal");
  });

  test('Get home filters', () {
    List<String> filters = MenuRepository.getHomeFilters();

    // Check that the number of filters returned is correct
    expect(filters.length, 5);

    // Check that the first filter is an empty string
    expect(filters[0], "");
    // Check that the second filter is "Salads"
    expect(filters[1], "Salads");
  });
}
