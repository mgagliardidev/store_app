import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/components/product_horizontal_card.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/models/user_info.dart';
import 'package:store_app/providers/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({super.key});

  UserInfo fetchUserInfo(WidgetRef ref) {
    if (Supabase.instance.client.auth.currentUser == null) {
      return UserInfo(userName: '', favPrdoucts: [], cartProducts: []);
    }

    final data =
        ref.watch(userProvider(Supabase.instance.client.auth.currentUser!.id));
    return data.value ??
        UserInfo(userName: '', favPrdoucts: [], cartProducts: []);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = fetchUserInfo(ref);
    ProductService productService = ProductService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your favourites',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
          child: FutureBuilder(
              future:
                  productService.fetchRecordsById(userInfo.favPrdoucts ?? []),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return _buildList(snapshot.data);
                } else if (snapshot.hasError) {
                  return const Text('Failed to load favourites');
                } else {
                  return const Text('No favourites yet');
                }
              })),
    );
  }

  Widget _buildList(List<Product>? favPrdoucts) {
    if (favPrdoucts == null || favPrdoucts.isEmpty) {
      return const Center(child: Text('No favourites yet'));
    }
    return ListView.builder(
      itemCount: favPrdoucts.length,
      itemBuilder: (context, index) {
        return ProductHorizontalCard(product: favPrdoucts[index], onTap: () {});
      },
    );
  }
}
