class AppCategory {
  final int id;
  final String name;
  final String image;
  final String desc;
  final int productCount;
  AppCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.desc,
    required this.productCount,
  });
  factory AppCategory.fromJson(Map<String, dynamic> json) => AppCategory(
        id: json["id"] as int,
        name: json["name"] as String,
        image: json["image"] as String,
        desc: json["desc"] as String,
        productCount: json["productCount"] as int,
      );
}
