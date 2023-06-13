import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/sherad/network/remote/api_manager.dart';

import '../Screens/drawer.dart';
import '../Screens/tabs.dart';

class Home_screen extends StatelessWidget {
  static const String routeName = "Home screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.horizontal(
              right: Radius.circular(20), left: Radius.circular(20)),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: ApiMngment.getSources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Column(
              children: [
                Text("Somting went wrong"),
                TextButton(onPressed: () {}, child: Text("Try Agin"))
              ],
            );
          }
          if (snapshot.data?.status != "ok") {
            print(snapshot.data?.status);
            return Column(
              children: [
                Text("Erorr!!"),
                TextButton(onPressed: () {}, child: Text("Try Agin"))
              ],
            );
          }
          var sources = snapshot.data?.sources ?? [];
          return tabsScreen(sources);
        },
      ),
    );
  }
}
