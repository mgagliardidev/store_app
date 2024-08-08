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

  Future<void> updateFavProducts(String id, List<String> productsIds) async {
    await supabase
        .from('user_info')
        .update({'fav_products': productsIds}).eq('user_id', id);
  }
}
