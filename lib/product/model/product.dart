class Product {
  final int id;
  final bool checked;
  final String name;
  final String image;
  final String stock;
  final double price;
  final String category;
  final List<String> tags;
  final DateTime dateTime;
  Product({
    required this.checked,
    required this.category,
    required this.id,
    required this.image,
    required this.stock,
    required this.price,
    required this.tags,
    required this.dateTime,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: json["category"],
        id: json["id"],
        image: json["image"],
        stock: json["stock"],
        price: json["price"],
        tags: json["tags"] ?? [],
        dateTime: DateTime.tryParse(json["dateTime"]) ?? DateTime.now(),
        name: json["name"],
        checked: json["checked"] ?? false,
      );
}

List<String> images = [
  "assets/image/image_1.jpg",
  "assets/image/image_2.jpg",
  "assets/image/image_3.jpg",
];
