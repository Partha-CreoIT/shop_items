import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_meals/data/categories.dart';
import 'package:shopping_meals/models/grocery_item.dart';

import '../data/dummy_items.dart';

class GroceryController extends GetxController {
  RxList<GroceryItem> groceryItemList = RxList<GroceryItem>();

  @override
  void onInit() async {
    super.onInit();
    await loadItems();
    groceryItemList.assignAll(groceryItems);
  }

  Future<void> loadItems() async {
    final url = Uri.https('flutter-shopping-meals-default-rtdb.firebaseio.com',
        'shopping-list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      groceryItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
  }
}

