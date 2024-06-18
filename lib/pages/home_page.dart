import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/components/custom_delegate_searchbar.dart';
import 'package:store_app/components/product_card.dart';
import 'package:store_app/components/promo_banner.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/providers/product_provider.dart';

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
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: 'Hi Matteo!\n',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 18)),
            TextSpan(
                text: 'Welcome to Shop!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 21))
          ]),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            onPressed: () {},
            child: ClipOval(
                //TODO: replace with user avatar
                child: Image.network(
                    "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg",
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50)),
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
}
