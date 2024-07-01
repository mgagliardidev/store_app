import 'package:flutter/material.dart';
import 'package:store_app/pages/search_results_page.dart';

class CustomDelegateSearchbar extends StatefulWidget {
  const CustomDelegateSearchbar({super.key});

  @override
  State<CustomDelegateSearchbar> createState() =>
      _CustomDelegateSearchbarState();
}

class _CustomDelegateSearchbarState extends State<CustomDelegateSearchbar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(builder: ((context, controller) {
      return SearchBar(
        hintText: "Search for product...",
        hintStyle: MaterialStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w200),
        ),
        controller: controller,
        onTap: () {
          //controller.openView();
        },
        onChanged: (_) {
          //controller.openView();
        },
        onSubmitted: (value) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SearchResultsPage(
                    query: value,
                  )));
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
    }));
  }
}
