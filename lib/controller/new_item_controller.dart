import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/grocery_item.dart';

class NewItemController extends GetxController {
  final formField = GlobalKey<FormState>();
  String? enteredName;
  int? enteredQuantity;
  Category? selectedCat;
  String? name;
  int? quantity;

  static const categories = {
    Categories.vegetables: Category(
      'Vegetables',
      Color.fromARGB(255, 0, 255, 128),
    ),
    Categories.fruit: Category(
      'Fruit',
      Color.fromARGB(255, 145, 255, 0),
    ),
    Categories.meat: Category(
      'Meat',
      Color.fromARGB(255, 255, 102, 0),
    ),
    Categories.dairy: Category(
      'Dairy',
      Color.fromARGB(255, 0, 208, 255),
    ),
    Categories.carbs: Category(
      'Carbs',
      Color.fromARGB(255, 0, 60, 255),
    ),
    Categories.sweets: Category(
      'Sweets',
      Color.fromARGB(255, 255, 149, 0),
    ),
    Categories.spices: Category(
      'Spices',
      Color.fromARGB(255, 255, 187, 0),
    ),
    Categories.convenience: Category(
      'Convenience',
      Color.fromARGB(255, 191, 0, 255),
    ),
    Categories.hygiene: Category(
      'Hygiene',
      Color.fromARGB(255, 149, 0, 255),
    ),
    Categories.other: Category(
      'Other',
      Color.fromARGB(255, 0, 225, 255),
    ),
  };

  void resetForm() {
    formField.currentState!.reset();
  }

  void validateForm() async {
    if (formField.currentState!.validate()) {
      formField.currentState?.save();
      final url = Uri.https(
          'flutter-shopping-meals-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Constant-type': 'application-json',
        },
        body: json.encode(
          {
            'name': enteredName!,
            'quantity': enteredQuantity!,
            'category': selectedCat!.title
          },
        ),

      );
      Get.back();
    }
  }
}
