

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/sherad/network/remote/api_manager.dart';

class Home_screen extends StatelessWidget {
  static const String routeName = "Home screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
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
          if (snapshot.data?.status!= "ok"){
            print(snapshot.data?.status);
            return Column(
              children: [

                Text("Erorr!!"),
                TextButton(onPressed: () {}, child: Text("Try Agin"))
              ],
            );
          }
          var sources = snapshot.data?.sources?? [];
          return ListView.builder(itemBuilder: (context, index) {
            return Text(sources[index].name ?? "");
          },itemCount: sources.length,);
        },
      ),
    );
  }
}
