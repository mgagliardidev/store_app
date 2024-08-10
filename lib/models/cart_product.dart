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

  factory CartProduct.fromDynamicElement(dynamic el) {
    return CartProduct(productId: el['productId'], quantity: el['quantity']);
  }

  // factory CartProduct.fromDynamicElement(dynamic el) {
  //   List<CartProduct> products = [];
  //   if (el is List) {
  //     //x = l.asMap().keys.map((k) => l[k]).toList();
  //     products = el
  //         .toList()
  //         .map((e) =>
  //             CartProduct(productId: e['productId'], quantity: e['quantity']))
  //         .toList();
  //   } else {
  //     products = [];
  //   }
  //   return products;
  // }
}
