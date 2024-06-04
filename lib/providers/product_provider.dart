import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/models/product.dart';

part 'product_provider.g.dart';

// init api
final productServices = Provider((ref) => ProductService());
List<Product> productList = [];

// final productsProvider = FutureProvider<List<Product>>((ref) async {
//   productList = await ref.read(productServices).fetchData();
//   return productList;
// });

@riverpod
Future<List<Product>> products(ref) async {
  productList = await ref.read(productServices).fetchData();
  return productList;
}
