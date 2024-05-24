import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/controller/inventory_controller.dart';
import 'package:inventory/model/items_model.dart';
import 'package:inventory/view/items/items_screen.dart';

class InventoryPage extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Dashboard')),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.teal],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final quantity = int.tryParse(_quantityController.text) ?? 0;

                if (name.isNotEmpty) {
                  itemController.addItem(name, quantity);
                  _nameController.clear();
                  _quantityController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Add Item'),
            ),
            Expanded(
              child: Obx(() {
                if (itemController.items.isEmpty) {
                  return const Center(
                    child: Text('Your inventory is empty'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: itemController.items.length,
                    itemBuilder: (context, index) {
                      final item = itemController.items[index];
                      return ListTile(
                        title: Text('ID: ${item.id} - ${item.name}'),
                        subtitle: Text('Quantity: ${item.quantity}'),
                        onTap: () {
                          Get.to(() => ItemDetailsPage(item: item));
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => itemController.deleteItem(item.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.sell),
                              onPressed: () {
                                _showSellDialog(context, item);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showSellDialog(BuildContext context, Item item) {
    final TextEditingController sellQuantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sell Item'),
          content: TextField(
            controller: sellQuantityController,
            decoration: const InputDecoration(labelText: 'Quantity to Sell'),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final quantityToSell = int.tryParse(sellQuantityController.text) ?? 0;
                if (quantityToSell > 0 && quantityToSell <= item.quantity) {
                  itemController.sellItem(item.id, quantityToSell);
                  sellQuantityController.clear();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid quantity to sell'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Sell'),
            ),
          ],
        );
      },
    );
  }
}
