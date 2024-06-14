// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:store_app/api/product_service.dart';
import 'package:store_app/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double cardWidth;
  final double cardHeight;

  ProductCard({
    super.key,
    required this.product,
    this.cardWidth = 60,
    this.cardHeight = 100,
  });

  final _borderRadius = BorderRadius.circular(50);

  @override
  Widget build(BuildContext context) {
    final imageHeight = cardHeight - (cardHeight / 100) * 40;

    return SizedBox(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Color.fromARGB(179, 210, 207, 207), width: 1),
          borderRadius: _borderRadius,
        ),
        //color: Colors.white,
        child: Stack(alignment: Alignment.topLeft, children: [
          ClipRRect(
            borderRadius: _borderRadius,
            child: Image.network(
              ProductService().getImageUrl(product.previewImage),
              fit: BoxFit.fill,
              height: imageHeight,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 4),
          Positioned(
            top: 190,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  RichText(
                      overflow: TextOverflow.fade,
                      text: TextSpan(children: [
                        TextSpan(
                            text: product.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 13)),
                        TextSpan(
                          text:
                              '\n${product.price.toStringAsFixed(2)}€      ${product.stars} ⭐',
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: 12),
                        )
                      ])),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 120,
            child: IconButton.filled(
              iconSize: 25,
              onPressed: () {},
              style: IconButton.styleFrom(backgroundColor: Colors.white60),
              icon: const Icon(
                Icons.favorite_outline_rounded,
                color: Colors.black,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
