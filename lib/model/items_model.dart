class Item {
  final int id;
  final String name;
  int quantity;
  double sellingPrice;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.sellingPrice,
  });

  factory Item.fromMap(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      sellingPrice: json['sellingPrice'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'sellingPrice': sellingPrice,
    };
  }
}
