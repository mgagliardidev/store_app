import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store_app/api/user_service.dart';
import 'package:store_app/models/user_info.dart';

part 'user_provider.g.dart';

final userServices = Provider((ref) => UserService());
UserInfo? userInfo;

@riverpod
Future<UserInfo> user(Ref ref, String id) async {
  userInfo ??= await ref.read(userServices).fetchDataById(id);

  return userInfo!;
}
