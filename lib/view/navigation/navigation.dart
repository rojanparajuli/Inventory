import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/controller/navigation_controller.dart';
import 'package:inventory/view/cart/cart_screen.dart';
import 'package:inventory/view/dashboard/dashboard.dart';
import 'package:inventory/view/home/inventory_screen.dart';

class FirstNavigation extends StatelessWidget {
  FirstNavigation({super.key});

  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (navigationController.selectedIndex.value) {
          case 0:
            return const Dashboard();
          case 1:
            return  InventoryPage();
          case 2:
            return const Cartscreen();
          default:
            return const Dashboard();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: navigationController.selectedIndex.value,
        onTap: navigationController.updateIndex,
      )),
    );
  }
}
