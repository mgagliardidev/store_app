import 'package:store_app/main.dart';
import 'package:store_app/models/user_info.dart';

class UserService {
  Future<UserInfo> fetchDataById(String id) async {
    final response = await supabase
        .from('user_info')
        .select('username,fav_products,cart_products')
        .eq('user_id', id)
        .withConverter<List<UserInfo>>(
            (data) => data.map(UserInfo.fromJson).toList());

    return response[0];
  }

  // Future<List<Product>> fetchDataBySearch(String query) {
  //   final response = supabase
  //       .from('products')
  //       .select()
  //       .or('name.ilike.%$query%,description.ilike.%$query%')
  //       .withConverter<List<Product>>(
  //           (data) => data.map(Product.fromJson).toList());

  //   return response;
  // }
}
