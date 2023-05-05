import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:shopping_meals/controller/new_item_controller.dart';
import 'package:shopping_meals/models/category.dart';

class NewItemScreen extends GetView<NewItemController> {
  NewItemScreen({super.key});

  final formField = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formField,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.length >= 50) {
                    return 'Must Have 1 to 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  controller.enteredName = value;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must Be a Valid Number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        controller.enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: DropdownButtonFormField(
                        items: [
                          for (final category
                              in NewItemController.categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(category.value.title),
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          controller.selectedCat = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.resetForm();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller.validateForm();
                      },
                      child: const Text('Add Item'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
