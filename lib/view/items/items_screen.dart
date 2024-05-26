import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inventory/controller/inventory_controller.dart';
import 'package:inventory/model/items_model.dart';

class ItemDetailsPage extends StatelessWidget {
  final Item item;

  const ItemDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Barcode barcode = Barcode.code39();
    final String svg = barcode.toSvg(item.id.toString());

    final TextEditingController quantityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final ItemController itemController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${item.id}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${item.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Quantity: ${item.quantity}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Barcode:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: SvgPicture.string(
                svg,
                height: 100, // Adjust the height as needed
                width: 300, // Adjust the width as needed
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity to Sell'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Selling Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final quantityToSell = int.tryParse(quantityController.text) ?? 0;
                final sellingPrice = double.tryParse(priceController.text) ?? 0.0;

                if (quantityToSell > 0 && sellingPrice > 0.0) {
                  itemController.sellItem(item.id ?? 0, quantityToSell, );
                  quantityController.clear();
                  priceController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Sell Item'),
            ),
          ],
        ),
      ),
    );
  }
}
