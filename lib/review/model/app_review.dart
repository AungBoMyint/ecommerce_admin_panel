class AppReview {
  final int id;
  final String author;
  final double rating;
  final String review;
  final String product;
  AppReview({
    required this.id,
    required this.author,
    required this.review,
    required this.product,
    required this.rating,
  });

  factory AppReview.fromJson(Map<String, dynamic> json) => AppReview(
        id: json["id"],
        author: json["author"],
        review: json["review"],
        product: json["product"],
        rating: json["rating"],
      );
}
