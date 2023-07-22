import 'package:flutter/material.dart';

import 'Screens/details_screen.dart';
import 'home/news_screen.dart';
import 'Screens/web_view_screen.dart';
import 'layout/home.dart';

void main() {
  runApp( NewsApp());


}

class NewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home_screen.routeName,
      routes: {
        Home_screen.routeName:(context)=>Home_screen(),
        DetailsScreen.routeName:(context)=>DetailsScreen(),
        WebViewScreen.routeName:(context)=>WebViewScreen(),

      },
    );
  }
}