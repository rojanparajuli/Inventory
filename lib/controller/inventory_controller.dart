import 'package:get/get.dart';
import 'package:inventory/data/database_helper.dart';

class ItemController extends GetxController {
  var items = [].obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    final data = await _dbHelper.getItems();
    items.value = data;
  }

  Future<int> addItem(String name, int quantity, ) async {
    int id = await _dbHelper.insertItem({
      'name': name,
      'quantity': quantity,
    });
    _refreshItems();
    return id;
  }

  Future<void> deleteItem(int id) async {
    await _dbHelper.deleteItem(id);
    _refreshItems();
  }
}
