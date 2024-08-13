import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/api/user_service.dart';
import 'package:store_app/models/cart_product.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/models/user_info.dart';
import 'package:store_app/providers/product_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInfoNotifier extends _$UserInfoNotifier {
  List<Product> _favProductsObjects = [];
  List<Product> _cartProductsObjects = [];
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

  Future<void> updateCartProducts(List<CartProduct> products) async {
    await UserService().updateCartProducts(
        Supabase.instance.client.auth.currentUser!.id, products);
    _cartProductsObjects.clear();
    _cartProductsObjects = await getCartProducts();
    ref.notifyListeners();
    //await updateState();
  }

  Future<void> updateSingleCartProduct(CartProduct product) async {
    state.value!.cartProducts
        ?.firstWhere((el) => el.productId == product.productId)
        .quantity = product.quantity;
    await updateCartProducts(state.value!.cartProducts!);
  }

  Future<List<Product>> getFavProducts() async {
    if (_favProductsObjects.isEmpty) {
      _favProductsObjects = await ProductService()
          .fetchRecordsById(state.value?.favPrdoucts ?? []);
    }
    return _favProductsObjects;
  }

  Future<List<Product>> getCartProducts() async {
    if (_cartProductsObjects.isEmpty) {
      _cartProductsObjects = await ProductService().fetchRecordsById(
          state.value?.cartProducts?.map((e) => e.productId).toList() ?? []);
    }
    return _cartProductsObjects;
  }

  void updateTotalCartPrice() {
    if (_cartProductsObjects.isEmpty || state.value!.cartProducts!.isEmpty) {
      totalCartPrice = 0.0;
      return;
    }

    state.value!.cartProducts?.forEach((cp) {
      totalCartPrice +=
          _cartProductsObjects.firstWhere((el) => cp.productId == el.id).price *
              cp.quantity;
    });
  }

  double getTotalCartPrice() {
    if (totalCartPrice == null || totalCartPrice == 0.0) {
      updateTotalCartPrice();
    }
    return totalCartPrice;
  }

  Future<void> updateState() async {
    state = AsyncData(await build());
    updateTotalCartPrice();
  }
}
