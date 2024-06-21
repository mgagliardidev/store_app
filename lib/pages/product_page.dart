import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/api/product_service.dart';
import 'package:store_app/models/product.dart';

class ProductPage extends ConsumerStatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  List<Image> productImages = [];
  int activeIndex = 0;
  late PageController _pageController;
  static const double borderRadius = 40;
  static const double sizeFactor = 0.37;

  @override
  void initState() {
    productImages.addAll(loadProductImages(widget.product));
    _pageController = PageController(viewportFraction: 1, initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * sizeFactor,
        child: AppBar(
          flexibleSpace: Stack(alignment: Alignment.center, children: [
            SizedBox(
              width: double.infinity,
              child: PageView.builder(
                itemCount: productImages.length,
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                pageSnapping: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: 11.0, left: 11.0, top: 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius)),
                      child: productImages[index],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 17,
              child: Row(
                children: indicators(productImages.length, activeIndex),
              ),
            )
          ]),
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius)),
          ),
        ),
      ),
      body: const Center(
        child: Text('Product Page'),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  List<Image> loadProductImages(Product product) {
    final images = <Image>[];
    images.add(Image.network(ProductService().getImageUrl(product.previewImage),
        fit: BoxFit.fill));
    for (var image in product.images) {
      images.add(Image.network(ProductService().getImageUrl(image)));
    }
    return images;
  }
}
