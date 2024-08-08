// lib/product_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/models/user_info.dart';
import 'package:store_app/providers/user_provider.dart';

class ProductHorizontalCard extends ConsumerStatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductHorizontalCard({super.key, required this.product, required this.onTap});

  @override
  ConsumerState<ProductHorizontalCard> createState() =>
      _ProductHorizontalCardState();
}

class _ProductHorizontalCardState extends ConsumerState<ProductHorizontalCard> {
  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoNotifierProvider).when(
        data: (data) => data,
        error: (s, t) =>
            UserInfo(userName: '', favPrdoucts: [], cartProducts: []),
        loading: () =>
            UserInfo(userName: '', favPrdoucts: [], cartProducts: []));
    final bool isFavourite = userInfo.favPrdoucts!.contains(widget.product.id);
    late bool isFavorite = true;
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 300,
          height: 100, // Define width for horizontal card
          padding: const EdgeInsets.all(8.0),
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
              const SizedBox(width: 16.0),
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
                            style: const TextStyle(
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
                          onPressed: () async {
                            List<String> updatedFavProducts =
                                userInfo.favPrdoucts!;
                            if (isFavourite) {
                              updatedFavProducts.remove(widget.product.id);
                            } else {
                              updatedFavProducts.add(widget.product.id);
                            }
                            ref
                                .read(userInfoNotifierProvider.notifier)
                                .updateFavProducts(updatedFavProducts);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, color: Colors.green),
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
