import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: const Text(
          'Hi, Matteo!', //TODO: replace with username
          style: TextStyle(fontWeight: FontWeight.bold),
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
              // search bar
              // TODO export widget
              SearchAnchor(builder: ((context, controller) {
                return SearchBar(
                  controller: controller,
                  elevation: MaterialStateProperty.all(3),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                );
              }), suggestionsBuilder: ((context, controller) {
                return List<ListTile>.generate(5, (index) {
                  final String item = 'Item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              })),
              const SizedBox(height: 15),
              // banner
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/images/promo_banner_50.jpeg',
                      fit: BoxFit.fill,
                      height: 160,
                      width: double.infinity,
                    ),
                  ),
                ),
              )
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
