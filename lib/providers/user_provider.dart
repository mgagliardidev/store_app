import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/api/user_service.dart';
import 'package:store_app/models/cart_item.dart';
import 'package:store_app/models/cart_product.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/models/user_info.dart';
import 'package:store_app/providers/product_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInfoNotifier extends _$UserInfoNotifier {
  List<Product> _favProductsObjects = [];
  List<CartProduct> _cartProducts = [];
  double totalCartPrice = 0.0;

  @override
  FutureOr<UserInfo> build() async {
    final s = await UserService()
        .fetchDataById(Supabase.instance.client.auth.currentUser!.id);

    return s;
  }

  Future<void> updateFavProducts(List<String> productsIds) async {
    await UserService().updateFavProducts(
        Supabase.instance.client.auth.currentUser!.id, productsIds);
    _favProductsObjects.clear();
    _favProductsObjects = await getFavProducts();
    ref.notifyListeners();
    //await updateState();
  }

  Future<List<Product>> getFavProducts() async {
    if (_favProductsObjects.isEmpty) {
      _favProductsObjects = await ProductService()
          .fetchRecordsById(state.value?.favPrdoucts ?? []);
    }
    return _favProductsObjects;
  }

  Future<void> fetchCartProducts() async {
    // get cart products id
    final ids = state.value?.cartItems
            ?.map((e) => e.productId)
            .toList()
            .cast<String>() ??
        [];

    if (ids.isEmpty) {
      _cartProducts = [];
      return;
    }
    final products = await ProductService().fetchRecordsById(ids);

    for (var product in products) {
      _cartProducts.add(CartProduct(
          product: product,
          quantity: state.value!.cartItems
                  ?.firstWhere((cartItem) => cartItem.productId == product.id)
                  .quantity ??
              1));
    }
  }

  Future<List<CartProduct>> getCartProducts() async {
    if (_cartProducts.isEmpty) {
      await fetchCartProducts();
    }

    return _cartProducts;
  }

  Future<void> updateCartItems(List<CartItem> cartItems) async {
    await UserService().updateCartItems(
        Supabase.instance.client.auth.currentUser!.id, cartItems);
    _cartProducts.clear();
    _cartProducts = await getCartProducts();
    ref.notifyListeners();
  }

  Future<void> updateSingleCartProduct(CartItem cartItem) async {
    await UserService().updateCartItems(
        Supabase.instance.client.auth.currentUser!.id, [cartItem]);
  }

  Future<void> updateState() async {
    state = AsyncData(await build());
  }
}
