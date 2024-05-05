class AppUser {
  final int id;
  final String fullName;
  final String phoneNo;
  final String image;
  final int points;
  AppUser({
    required this.id,
    required this.fullName,
    required this.phoneNo,
    required this.image,
    required this.points,
  });
  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        fullName: json["fullName"],
        phoneNo: json["phoneNo"],
        image: json["image"],
        points: json["points"],
      );
}
