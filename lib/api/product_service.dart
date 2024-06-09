import 'package:store_app/main.dart';
import 'package:store_app/models/product.dart';

class ProductService {
  Future<List<Product>> fetchData() async {
    final response = await supabase.from('products').select();
    return response.map<Product>((e) => Product.fromJson(e)).toList();
  }

  String getImageUrl(String imagePath) {
    return supabase.storage
        .from('products_images')
        .getPublicUrl(imagePath)
        .toString();
  }
}
