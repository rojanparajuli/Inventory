class Item {
  int id;
  String name;
  int quantity;

  Item({required this.id, required this.name, required this.quantity});

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "quantity": quantity,
      };
}
