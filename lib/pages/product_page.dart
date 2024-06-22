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
  static const double sizeFactor = 0.45;

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
                        const EdgeInsets.only(right: 20.0, left: 20.0, top: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius),
                          topLeft: Radius.circular(borderRadius)),
                      child: productImages[index],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 45,
              right: 30,
              child: IconButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.grey.withOpacity(0.5))),
                icon: const Icon(Icons.favorite_border, color: Colors.black),
                selectedIcon: const Icon(Icons.favorite, color: Colors.black),
                isSelected: false,
                onPressed: () {
                  // TODO: Add favorite logic
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              // Product Name and Price
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    "\$${widget.product.price}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  const Spacer(),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: widget.product.stars.toString(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 18),
                    ),
                    const WidgetSpan(
                        child: Icon(Icons.star, color: Colors.amber, size: 20)),
                  ]))
                ],
              ),
              const SizedBox(height: 25),
              // Product Description
              const Text(
                "Product Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                widget.product.description,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 25),
              // Shipping info
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "Shipping Info ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
                const WidgetSpan(
                    child: Icon(
                  Icons.local_shipping,
                  size: 18,
                ))
              ])),
              const Text(
                "Free Shipping 3/4 business days",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 300,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Add to Cart  ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  WidgetSpan(
                      child: Icon(
                    Icons.shopping_cart,
                    size: 20,
                  ))
                ])),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
