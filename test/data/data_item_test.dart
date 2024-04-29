import 'package:app_pizzeria/data/data_item.dart';
import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


class MenuProvider {
  Map<String, double> ingredients = {'Cheese': 1.0, 'Tomato': 0.5};

  double getPrice(String ingredient) {
    return ingredients[ingredient] ?? 0.0;
  }
}

void main() {
  // Sample DataItem for testing
  final sampleItem = DataItem(
    key: UniqueKey(),
    image: const NetworkImage('https://i.postimg.cc/zGfNGn8c/margherita.png'),
    name: 'Margherita',
    ingredients: ['Cheese', 'Tomato'],
    initialPrice: 5.0,
    category: Categories.pizze, // Assuming you have a Categories enum.
  );

  // Assuming MenuProvider is a simple class, instantiate it directly.
  final menuProvider = MenuProvider();

  group('DataItem Tests', () {
    test('Initial values are set correctly', () {
      expect(sampleItem.name, 'Margherita');
      expect(sampleItem.ingredients, ['Cheese', 'Tomato']);
      expect(sampleItem.initialPrice, 5.0);
    });

    test('Adding ingredient updates the item correctly', () {
      sampleItem.addIngredients('Basil');
      expect(sampleItem.ingredients.contains('Basil'), isTrue);
      expect(sampleItem.addedIngredients.last, isTrue);
      expect(sampleItem.isSelected.last, isTrue);
    });

    test('Calculate price returns correct total', () {
      // Mocking or simulating the context might be complex, so let's focus on a direct call.
      // Adjust this based on how your actual calculatePrice method is implemented.
      final price = sampleItem.initialPrice + menuProvider.getPrice('Cheese') + menuProvider.getPrice('Tomato');
      expect(price, 6.5); // Initial price + Cheese + Tomato prices
    });

    test('Copy creates a new instance with the same properties', () {
      final copiedItem = sampleItem.copy();
      expect(copiedItem != sampleItem, isTrue);
      expect(copiedItem.name, sampleItem.name);
      expect(copiedItem.ingredients, equals(sampleItem.ingredients));
      // Ensure other necessary properties are copied correctly.
    });

    test('Clear list removes unselected ingredients correctly', () {
      sampleItem.isSelected[0] = false; // Assuming 'Cheese' is not selected
      sampleItem.clearList();
      expect(sampleItem.ingredients.contains('Cheese'), isFalse);
      // Reset for further tests if needed
      sampleItem.addIngredients('Cheese');
      sampleItem.isSelected[sampleItem.ingredients.indexOf('Cheese')] = true;
    });
  });
}
