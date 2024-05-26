import 'package:get/get.dart';
import 'package:inventory/data/database_helper.dart';
import 'package:inventory/model/items_model.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;
  var outOfStockStatuses = <bool>[].obs;
  @override
  void onInit() {
    super.onInit();
    _loadItems();
  }

  void _loadItems() async {
    final List<Map<String, dynamic>> storedItems = await DatabaseHelper().getItems();
    items.value = storedItems.map((item) => Item.fromMap(item)).toList();
    _initializeOutOfStockStates();
  }

  void _saveItem(Item item) async {
    await DatabaseHelper().updateItem(item.toMap());
    _loadItems();
  }

  void addItem(String name, int quantity, double sellingPrice) async {
    Item newItem = Item(name: name, quantity: quantity, sellingPrice: sellingPrice);
    await DatabaseHelper().insertItem(newItem.toMap());
    _loadItems();
  }

  void deleteItem(int id) async {
    await DatabaseHelper().deleteItem(id);
    _loadItems();
  }

  void sellItem(int id, int quantityToSell) async {
    try {
      await DatabaseHelper().sellItem(id, quantityToSell);
      _loadItems();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void _initializeOutOfStockStates() {
    outOfStockStatuses.value = List<bool>.filled(items.length, false); 
  }

   void toggleOutOfStock(int index) {
  
 if (index >= 0 && index < outOfStockStatuses.length) {
      outOfStockStatuses[index] = !outOfStockStatuses[index];
    }
  }
}
