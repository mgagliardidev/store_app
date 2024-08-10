class CartProduct {
  String productId;
  int quantity;
  CartProduct({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      quantity: map['quantity'] as int,
      productId: map['product_id'] as String,
    );
  }

  factory CartProduct.fromDynamicElement(dynamic el) {
    return CartProduct(productId: el['productId'], quantity: el['quantity']);
  }
}
