import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/details_screen.dart';
import 'blocChange.dart';
import 'home/cubit/cubit.dart';
import 'home/news_screen.dart';
import 'Screens/web_view_screen.dart';
import 'layout/home.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp( NewsApp());


}

class NewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Home_screen.routeName,
        routes: {
          Home_screen.routeName:(context)=>Home_screen(),
          DetailsScreen.routeName:(context)=>DetailsScreen(),
          WebViewScreen.routeName:(context)=>WebViewScreen(),

        },
      ),
    );
  }
}