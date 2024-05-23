import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ItemController extends GetxController {
  var items = [].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadItems();
  }

  void _loadItems() {
    List<dynamic>? storedItems = storage.read<List>('items');
    if (storedItems != null) {
      items.value = storedItems;
    }
  }

  void _saveItems() {
    storage.write('items', items.toList());
  }

  void addItem(String name, int quantity) {
    int id = DateTime.now().millisecondsSinceEpoch; //  unique ID..................
    items.add({
      'id': id,
      'name': name,
      'quantity': quantity,
    });
    _saveItems();
  }

  void deleteItem(int id) {
    items.removeWhere((item) => item['id'] == id);
    _saveItems();
  }
}
