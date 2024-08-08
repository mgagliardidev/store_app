class CartProduct {
  String productId;
  int quantity;
  CartProduct({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'quantity': quantity,
      };

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      quantity: map['quantity'] as int,
      productId: map['product_id'] as String,
    );
  }
}
