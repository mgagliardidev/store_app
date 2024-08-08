import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store_app/api/user_service.dart';
import 'package:store_app/models/user_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_provider.g.dart';

@riverpod
class UserInfoNotifier extends _$UserInfoNotifier {
  @override
  FutureOr<UserInfo> build() async {
    return await UserService()
        .fetchDataById(Supabase.instance.client.auth.currentUser!.id);
  }

  Future<void> updateFavProducts(List<String> productsIds) async {
    await UserService().updateFavProducts(
        Supabase.instance.client.auth.currentUser!.id, productsIds);
    await updateState();
  }

  Future<void> updateState() async {
    state = AsyncData(await build());
  }
}


// final userServices = Provider((ref) => UserService());
// UserInfo? userInfo;

// @riverpod
// Future<UserInfo> user(Ref ref, String id, bool isUpdate) async {
//   if (userInfo == null || isUpdate) {
//     userInfo ??= await ref.read(userServices).fetchDataById(id);
//   }
//   return userInfo!;
// }

// Future<void> updateFavProducts(
//     WidgetRef ref, String userId, List<String> productsIds) async {
//   await ref.read(userServices).updateFavProducts(userId, productsIds);

//   ref.read(userProvider)
// }
