import 'dart:math';

final List<Category> categories = [
  Category(name: "Shirt", hasChild: true, children: [
    Category(
      name: "Men",
      hasChild: true,
      children: [
        Category(
          name: "T-Shirt",
          hasChild: false,
          children: [],
        ),
        Category(
          name: "Sport-Shirt",
          hasChild: false,
          children: [],
        ),
      ],
    ),
    Category(
      name: "Women",
      hasChild: true,
      children: [
        Category(
          name: "Sports Bra",
          hasChild: false,
          children: [],
        ),
        Category(
          name: "V-neck Shirt",
          hasChild: false,
          children: [],
        ),
      ],
    ),
  ]),
  Category(name: "Electronics", hasChild: true, children: [
    Category(name: "Computers & Accessories ", hasChild: true, children: [
      Category(name: "Laptops", hasChild: true, children: [
        Category(name: "Gaming Laptops", hasChild: true, children: [
          Category(
              name: "High-Performance Gaming Laptops ",
              hasChild: false,
              children: [])
        ])
      ])
    ])
  ])
];

class Category {
  final String name;
  final bool hasChild;
  final List<Category> children;
  Category(
      {required this.name, required this.hasChild, required this.children});
}

List<String> freeShippingTypeList = [
  "A valid free shipping coupon",
  "A minumun order amount",
  "A minumun order amount OR a coupon",
  "A minumun order amount AND a coupon",
];

List<String> products = [
  "Basic Programming Language",
  "AI model tranning with Python",
  "Advance English Course",
  "Understanding Design Pattern",
  "Figma Course For Beginner",
  "Photoshop Full Course",
  "Machine Learning With Python",
  "Java for Bank Network",
  "What are you doing right now?",
  "Understanding what you are in real life!",
  "Know yourself about your job.",
];

List favoriteFlavors = [
  {
    "avatar": 'assets/bubbletea.png',
    "label": 'Classic Milk Tea',
    "amount": "4,976 Cups",
    "time": "⭐⭐⭐⭐⭐",
    "status": "Very Excellent",
  },
  {
    "avatar": 'assets/bbt.png',
    "label": 'Tiger Milk Tea',
    "amount": "3,553 Cups",
    "time": "⭐⭐⭐⭐",
    "status": "Excellent",
  },
  {
    "avatar": 'assets/bubbletea.png',
    "label": 'Thai Milk Tea',
    "amount": "2,544 Cups",
    "time": "⭐⭐⭐",
    "status": "Good",
  },
];

List<Map<String, dynamic>> dailyData = List.generate(31, (index) {
  return {"value": Random().nextInt(100)};
});
List<Map<String, dynamic>> monthlyData = List.generate(12, (index) {
  return {"value": Random().nextInt(100)};
});
