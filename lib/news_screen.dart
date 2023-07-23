import 'package:flutter/material.dart';
import 'package:news/sherad/network/remote/api_manager.dart';

import 'Screens/tabs.dart';
import 'model/categoryModel.dart';

class NewsScreen extends StatelessWidget {
  CategoryModel categoryModel;

  NewsScreen(this.categoryModel);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiMngment.getSources(categoryModel.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Column(
            children: [
              const Text("Something went wrong"),
              TextButton(
                onPressed: () {},
                child: const Text("Try Again"),
              )
            ],
          );
        }

        if (snapshot.data?.status != "ok") {
          return Column(
            children: [
              const Text("Error ..!!"),
              TextButton(
                onPressed: () {},
                child: const Text("Try Again"),
              )
            ],
          );
        }
        var sources = snapshot.data?.sources ?? [];
        return tabsScreen(sources);
      },
    );
  }
}