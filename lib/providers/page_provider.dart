import 'package:flutter/material.dart';
import '../widget/menu_widget/categories_buttons_tab.dart';

class PageProvider with ChangeNotifier {
  Categories _selectedCategories = Categories.pizza;
  int selectedPage = 0;

  Categories get selectedCategory => _selectedCategories;

  void changePage(int page, {selectedCategories = Categories.pizza}) {
    _selectedCategories = selectedCategories;
    selectedPage = page;
    notifyListeners();
  }
}
