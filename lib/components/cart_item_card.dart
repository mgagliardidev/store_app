// lib/cart_item_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/models/cart_product.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/providers/user_provider.dart';

class CartItemCard extends ConsumerStatefulWidget {
  final Product product;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  CartItemCard({
    required this.product,
    required this.onRemove,
    required this.onTap,
  });

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends ConsumerState<CartItemCard> {
  int quantity = 1;

  // void incrementQuantity() {
  //   setState(() {
  //     quantity++;
  //   });
  // }

  // void decrementQuantity() {
  //   setState(() {
  //     if (quantity > 1) {
  //       quantity--;
  //     }
  //   });
  // }

  void decrementQuantity() async {
    if (quantity > 1) {
      quantity--;
      ref
          .read(userInfoNotifierProvider.notifier)
          .updateSingleCartProduct(CartProduct(
            productId: widget.product.id,
            quantity: quantity,
          ));
    }
  }

  void incrementQuantity() async {
    quantity++;
    ref
        .read(userInfoNotifierProvider.notifier)
        .updateSingleCartProduct(CartProduct(
          productId: widget.product.id,
          quantity: quantity,
        ));
  }

  // void updateQuantity() {
  //   if (quantity >= 1) {
  //     ref
  //         .read(userInfoNotifierProvider.notifier)
  //         .updateSingleCartProduct(CartProduct(
  //           productId: widget.product.id,
  //           quantity: quantity,
  //         ));
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    quantity = ref
            .watch(userInfoNotifierProvider)
            .value
            ?.cartProducts
            ?.firstWhere((el) => el.productId == widget.product.id)
            .quantity ??
        1;
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 300,
          height: 160,
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
              // Product info and quantity controls
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
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: widget.onRemove,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: decrementQuantity,
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: incrementQuantity,
                        ),
                      ],
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
