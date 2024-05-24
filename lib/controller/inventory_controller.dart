import 'package:get/get.dart';
import 'package:inventory/data/database_helper.dart';
import 'package:inventory/model/items_model.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;
  final dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  void loadItems() async {
    final List<Map<String, dynamic>> maps = await dbHelper.getItems();
    items.value = maps.map((item) => Item.fromMap(item)).toList();
  }

  void addItem(String name, int quantity) async {
    final item = Item(id: 0, name: name, quantity: quantity);
    await dbHelper.insertItem(item.toMap());
    loadItems();
  }

  void deleteItem(int id) async {
    await dbHelper.deleteItem(id);
    loadItems();
  }

  void sellItem(int id, int quantitySold) async {
    final item = items.firstWhere((item) => item.id == id);
    if (item.quantity >= quantitySold) {
      item.quantity -= quantitySold;
      await dbHelper.updateItem(item.toMap());
      loadItems();
    } else {
      Get.snackbar("Error", "Not enough quantity to sell");
    }
  }
}
