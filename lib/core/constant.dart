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
