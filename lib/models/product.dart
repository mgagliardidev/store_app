// ignore_for_file: public_member_api_docs, sort_constructors_first

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stars;
  final String previewImage;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stars,
    required this.previewImage,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        stars: json['stars'],
        previewImage: json['preview_image'],
        images: List<String>.from(json['images']));
  }
}
