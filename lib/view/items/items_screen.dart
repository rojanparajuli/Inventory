import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:inventory/model/items_model.dart';

class ItemDetailsPage extends StatelessWidget {
  final Item item;

  const ItemDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Barcode barcode = Barcode.code39();
    final String svg = barcode.toSvg(item.id.toString());

    final Uint8List bytes = Uint8List.fromList(svg.codeUnits);

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
              child: Image.memory(bytes),
            ),
          ],
        ),
      ),
    );
  }
}
