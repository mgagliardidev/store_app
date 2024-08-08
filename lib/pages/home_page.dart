import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/components/custom_delegate_searchbar.dart';
import 'package:store_app/components/product_card.dart';
import 'package:store_app/components/promo_banner.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/models/user_info.dart';
import 'package:store_app/providers/product_provider.dart';
import 'package:store_app/providers/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<Product> fetchData() {
    final data = ref.watch(productsProvider);
    return data.value ?? [];
  }

  final double _crossAxisSpacing = 5, _mainAxisSpacing = 9;
  final int _crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    final productList = fetchData();
    final userInfo = ref.watch(userInfoNotifierProvider).when(
        data: (data) => data,
        error: (s, t) =>
            UserInfo(userName: '', favPrdoucts: [], cartProducts: []),
        loading: () =>
            UserInfo(userName: '', favPrdoucts: [], cartProducts: []));

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Hi ${userInfo.userName}!\n',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 18)),
            TextSpan(
                text: 'Welcome to Shop!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Theme.of(context).colorScheme.tertiary))
          ]),
        ),
        actions: [
          // logout button
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 2),
            child: IconButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut().then(
                      (value) =>
                          Navigator.of(context).pushReplacementNamed('/'),
                    );
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SEARCH BAR
                      const CustomDelegateSearchbar(),
                      const SizedBox(height: 20),
                      // BANNER
                      PromoBanner(
                          imagePath: 'assets/images/promo_banner_50.jpeg',
                          onTap: () {}),
                      const SizedBox(height: 20),
                      // PRODUCTS
                      GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: _crossAxisCount,
                          crossAxisSpacing: _crossAxisSpacing,
                          mainAxisSpacing: _mainAxisSpacing,
                          children: List.generate(productList.length, (index) {
                            return ProductCard(
                              product: productList[index],
                            );
                          }))
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(String title, List<String> content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    for (var item in content) Text(item),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
