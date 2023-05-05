import 'package:shopping_meals/data/categories.dart';
import 'package:shopping_meals/models/grocery_item.dart';
import '../models/category.dart';

var groceryItems = [
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!),
];
