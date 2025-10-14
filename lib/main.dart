import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kameleoon Plugin Demo",
      theme: ThemeData(
        primaryColor: Color.fromRGBO(100, 100, 255, 1),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
