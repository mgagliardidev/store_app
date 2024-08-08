import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/components/product_horizontal_card.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/models/user_info.dart';
import 'package:store_app/pages/product_page.dart';
import 'package:store_app/providers/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoNotifierProvider).when(
        data: (data) => data,
        error: (s, t) =>
            UserInfo(userName: '', favPrdoucts: [], cartProducts: []),
        loading: () =>
            UserInfo(userName: '', favPrdoucts: [], cartProducts: []));
    ProductService productService = ProductService();
    final products =
        productService.fetchRecordsById(userInfo.favPrdoucts ?? []);

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
              future: products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildList(snapshot.data);
                }
                return const Center(child: CircularProgressIndicator());
              })),
    );
  }

  Widget _buildList(List<Product>? favPrdoucts) {
    if (favPrdoucts == null || favPrdoucts.isEmpty) {
      final String message = Supabase.instance.client.auth.currentUser == null
          ? 'Sign in to see your favourites!'
          : 'No favourites yet';
      return Center(child: Text(message));
    }

    return ListView.builder(
      itemCount: favPrdoucts.length,
      itemBuilder: (context, index) {
        return ProductHorizontalCard(
            product: favPrdoucts[index],
            onTap: () {
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductPage(
                          product: favPrdoucts[index],
                        )));
              }
            });
      },
    );
  }
}
