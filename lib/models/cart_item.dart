class CartItem {
  String productId;
  int quantity;
  CartItem({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      quantity: map['quantity'] as int,
      productId: map['product_id'] as String,
    );
  }

  factory CartItem.fromDynamicElement(dynamic el) {
    return CartItem(productId: el['productId'], quantity: el['quantity']);
  }
}
