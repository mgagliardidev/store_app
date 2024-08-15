import 'package:store_app/models/product.dart';

class CartProduct {
  final Product product;
  final int quantity;

  CartProduct({required this.product, required this.quantity});
}
