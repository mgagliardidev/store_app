import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/components/custom_delegate_searchbar.dart';
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

  @override
  Widget build(BuildContext context) {
    final productList = fetchData();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SEARCH BAR
              const CustomDelegateSearchbar(),
              const SizedBox(height: 20),
              // BANNER
              PromoBanner(
                  imagePath: 'assets/images/promo_banner_50.jpeg',
                  onTap: () {}),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: productList.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return ListTile(
              //         title: Text(productList[index].name),
              //       );
              //     },
              //   ),
              // )
            ]),
      ),
    );
  }
}
