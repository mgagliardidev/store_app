import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/components/custom_delegate_searchbar.dart';
import 'package:store_app/components/product_card.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/pages/home_page.dart';
import 'package:store_app/pages/main_page.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;
  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

Future<List<Product>> fetchDataBySearch(String query) {
  return ProductService().fetchDataBySearch(query);
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late Future<List<Product>> resultFuture;

  @override
  void initState() {
    super.initState();
    resultFuture = fetchDataBySearch(widget.query);
  }

  final double _crossAxisSpacing = 5, _mainAxisSpacing = 9;
  final int _crossAxisCount = 2;

  _onBackPressed(bool didPop) {
    if (didPop) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => MainPage()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;
    return PopScope(
      onPopInvoked: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.tertiary),
          title: Text(
            "\"${widget.query}\" Search Results",
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomDelegateSearchbar(),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                FutureBuilder(
                    future: resultFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final productRes = snapshot.data!;
                      return GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: _crossAxisCount,
                          crossAxisSpacing: _crossAxisSpacing,
                          mainAxisSpacing: _mainAxisSpacing,
                          children: List.generate(productRes.length, (index) {
                            return ProductCard(
                              product: productRes[index],
                            );
                          }));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
