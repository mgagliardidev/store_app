// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:store_app/models/cart_product.dart';

class UserInfo {
  late String userName;
  late List<String>? favPrdoucts;
  late List<CartProduct>? cartProducts;

  UserInfo({
    required this.userName,
    required this.favPrdoucts,
    required this.cartProducts,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        userName: json['username'],
        favPrdoucts: List<String>.from(json['fav_products'] ?? []),
        cartProducts: (json['cart_products'] as List)
            .map((el) => CartProduct.fromDynamicElement(el))
            .toList());
  }
}
