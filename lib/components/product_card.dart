import 'package:flutter/material.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/pages/product_page.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
                  product: product,
                )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Product Image
              Positioned.fill(
                child: Image.network(
                  ProductService().getImageUrl(product.previewImage),
                  fit: BoxFit.cover,
                ),
              ),
              // Favorite Icon Button
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.withOpacity(0.5))),
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  selectedIcon: const Icon(Icons.favorite, color: Colors.black),
                  isSelected: false,
                  onPressed: () {
                    // TODO: Add favorite logic
                  },
                ),
              ),
              // Product Details
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            product.stars.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
