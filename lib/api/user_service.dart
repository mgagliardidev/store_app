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
}
