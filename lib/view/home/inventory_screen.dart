import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/controller/inventory_controller.dart';
import 'package:inventory/model/items_model.dart';
import 'package:inventory/view/items/items_screen.dart';

class InventoryPage extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Selling Price'),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final quantity = int.tryParse(_quantityController.text) ?? 0;
                final price = double.tryParse(_priceController.text) ?? 0.0;

                if (name.isNotEmpty && quantity > 0 && price > 0.0) {
                  itemController.addItem(name, quantity, price);
                  _nameController.clear();
                  _quantityController.clear();
                  _priceController.clear();
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
                      return Obx(()=> Container(
                          color: itemController.items.isNotEmpty && index < itemController.outOfStockStatuses.length && itemController.outOfStockStatuses[index] ? Colors.red: Colors.transparent,
                          child: ListTile(
                            title: Text('ID: ${item.id} - ${item.name}'),
                            subtitle: Text('Quantity: ${item.quantity}'),
                            onTap: () {
                              Get.to(() => ItemDetailsPage(item: item));
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.inventory),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: itemController.outOfStockStatuses[index] ? const Text('Confirm Restock') : const Text("Confirm Out Of Stock"),
                                          content: itemController.outOfStockStatuses[index] ? const Text('Are you sure this item is Restock') : const Text("Are you sure this item is out of stock?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text("Yes"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                itemController.toggleOutOfStock(index);
                                                print(itemController.outOfStockStatuses);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.sell),
                                  onPressed: () {
                                    _showSellDialog(context, item);
                                  },
                                ),
                              ],
                            ),
                          ),
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
    final TextEditingController sellPriceController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sell Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: sellQuantityController,
                decoration: const InputDecoration(labelText: 'Quantity to Sell'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: sellPriceController,
                decoration: const InputDecoration(labelText: 'Selling Price'),
                keyboardType: TextInputType.number,
              ),
            ],
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
                final sellingPrice = double.tryParse(sellPriceController.text) ?? 0.0;

                if (quantityToSell > 0 && quantityToSell <= item.quantity && sellingPrice > 0.0) {
                  itemController.sellItem(item.id ?? 0, quantityToSell);
                  sellQuantityController.clear();
                  sellPriceController.clear();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid quantity or price'),
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
