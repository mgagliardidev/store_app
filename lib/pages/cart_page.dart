import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/components/cart_item_card.dart';
import 'package:store_app/components/product_horizontal_card.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/models/user_info.dart';
import 'package:store_app/pages/product_page.dart';
import 'package:store_app/providers/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends ConsumerWidget {
  CartPage({super.key});

  double totalCartPrice = 0.0;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final products =
        ref.watch(userInfoNotifierProvider.notifier).getCartProducts();
    
    // final c = ref
    //     .read(userInfoNotifierProvider)
    //     .value
    //     ?.cartProducts
    //     ?.firstWhere((product) => product.productId == 'ff').quantity;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: products,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _buildList(snapshot.data);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                  top:
                      BorderSide(color: Theme.of(context).colorScheme.tertiary),
                )),
                child: Row(children: [
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: 'Total: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey)),
                    TextSpan(
                        text:
                            '\$${await ref.read(userInfoNotifierProvider.notifier).getTotalCartPrice()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey)),
                  ])),
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          shape: const StadiumBorder()),
                      onPressed: () {},
                      child: const Text('Confirm Order'))
                ]),
              )
            ],
          )),
    );
  }

  // double getTotalPrice(WidgetRef ref, List<Product>? cartProducts) {
  //   double total = 0.0;
  //   cartProducts!.forEach((el) => {
  //         total += ref
  //                 .read(userInfoNotifierProvider)
  //                 .value!
  //                 .cartProducts!
  //                 .firstWhere((e) => e.productId == el.id)
  //                 .quantity *
  //             el.price
  //       });

  //   return total;
  // }

  Widget _buildList(List<Product>? cartProducts) {
    if (cartProducts == null || cartProducts.isEmpty) {
      final String message = Supabase.instance.client.auth.currentUser == null
          ? 'Sign in to see your favourites!'
          : 'No favourites yet';
      return Center(child: Text(message));
    }

    return ListView.builder(
      itemCount: cartProducts.length,
      itemBuilder: (context, index) {
        return CartItemCard(
            product: cartProducts[index],
            onRemove: () {},
            onTap: () {
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductPage(
                          product: cartProducts[index],
                        )));
              }
            });
      },
    );
  }
}
