import 'dart:async';

import 'package:store_app/main.dart';
import 'package:store_app/models/product.dart';

class ProductService {
  Future<List<Product>> fetchData() async {
    final response = await supabase.from('products').select();
    return response.map<Product>((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> fetchDataBySearch(String query) {
    final response = supabase
        .from('products')
        .select()
        .or('name.ilike.%$query%,description.ilike.%$query%')
        .withConverter<List<Product>>(
            (data) => data.map(Product.fromJson).toList());

    return response;
  }

  Future<List<Product>> fetchRecordsById(List<String> ids) async {
    final response = await supabase
        .from('products')
        .select()
        .inFilter('id', ids)
        .withConverter<List<Product>>(
            (data) => data.map(Product.fromJson).toList());
    return response;
  }

  String getImageUrl(String imagePath) {
    return supabase.storage
        .from('products_images')
        .getPublicUrl(imagePath)
        .toString();
  }
}
