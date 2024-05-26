class Item {
  int? id;
  String name;
  int quantity;
  double sellingPrice;

  Item({
    this.id,
    required this.name,
    required this.quantity,
    required this.sellingPrice,
  });

  factory Item.fromMap(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      sellingPrice: json['sellingPrice'] != null ? (json['sellingPrice'] as num).toDouble() : 0.0,
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
