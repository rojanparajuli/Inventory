import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory/model/items_model.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadItems();
  }

  void _loadItems() {
    List<dynamic>? storedItems = storage.read<List>('items');
    if (storedItems != null) {
      items.value = storedItems.map((item) => Item.fromJson(item)).toList();
    }
  }

  void _saveItems() {
    storage.write('items', items.map((item) => item.toJson()).toList());
  }

  void addItem(String name, int quantity) {
    int id = DateTime.now().millisecondsSinceEpoch;
    items.add(Item(id: id, name: name, quantity: quantity));
    _saveItems();
  }

  void deleteItem(int id) {
    items.removeWhere((item) => item.id == id);
    _saveItems();
  }
}
