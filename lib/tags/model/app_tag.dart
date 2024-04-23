class AppTag {
  final int id;
  final String name;
  final String slug;
  final int count;
  const AppTag({
    required this.id,
    required this.name,
    required this.slug,
    required this.count,
  });
  factory AppTag.fromJson(Map<String, dynamic> json) => AppTag(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        count: json["count"],
      );
}
