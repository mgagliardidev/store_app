import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Image.network(
                  "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg",
                  fit: BoxFit.fill,
                  width: 50,
                  height: 50)),
        )
      ],
    ));
  }
}
