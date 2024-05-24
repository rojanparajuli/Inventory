class Item {
  final int id;
  final String name;
  int quantity;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
