// lib/product_card.dart

import 'package:flutter/material.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/models/product.dart';

class ProductHorizontalCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  ProductHorizontalCard({required this.product, required this.onTap});

  @override
  _ProductHorizontalCardState createState() => _ProductHorizontalCardState();
}

class _ProductHorizontalCardState extends State<ProductHorizontalCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      isFavorite = true;
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 300,
          height: 100, // Define width for horizontal card
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  ProductService().getImageUrl(widget.product.previewImage),
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(width: 16.0),
              // Product info and favorite button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: toggleFavorite,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
