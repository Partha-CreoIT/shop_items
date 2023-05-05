import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_meals/controller/grocery_controller.dart';
import 'package:shopping_meals/controller/new_item_controller.dart';

import 'new_item.dart';

class GroceryList extends GetView<GroceryController> {
  const GroceryList({Key? key}) : super(key: key);

  void _addItem() async {
    Get.put(NewItemController());
    await Get.to(() => NewItemScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Obx(
            () {
          if (controller.groceryItemList.isEmpty) {
            return const Center(
              child: Text('No Items Added Yet'),
            );
          }
          return ListView.builder(
            itemCount: controller.groceryItemList.length,
            itemBuilder: (ctx, index) => Dismissible(
              onDismissed: (direction) {
                controller.groceryItemList.removeAt(index);
              },
              key: ValueKey(controller.groceryItemList[index].id),
              child: ListTile(
                title: Text(controller.groceryItemList[index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: controller.groceryItemList[index].category.color,
                ),
                trailing: Text(
                  controller.groceryItemList[index].quantity.toString(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

