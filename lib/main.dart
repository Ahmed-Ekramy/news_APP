import 'package:flutter/material.dart';

import 'layout/home.dart';

void main() {
  runApp( NewsApp());


}

class NewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Home_screen.routeName,
      routes: {
        Home_screen.routeName:(context)=>Home_screen(),
      },
    );
  }
}