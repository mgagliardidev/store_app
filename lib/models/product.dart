class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stars;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.stars});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        stars: json['stars']);
  }
}
