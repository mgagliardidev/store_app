// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:store_app/models/cart_item.dart';

class UserInfo {
  late String userName;
  late List<String>? favPrdoucts;
  late List<CartItem>? cartItems;

  UserInfo({
    required this.userName,
    required this.favPrdoucts,
    required this.cartItems,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        userName: json['username'],
        favPrdoucts: List<String>.from(json['fav_products'] ?? []),
        cartItems: (json['cart_products'] as List)
            .map((el) => CartItem.fromDynamicElement(el))
            .toList());
  }
}
