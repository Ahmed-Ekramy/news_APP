import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Screens/widget/newsItem.dart';
import 'package:news/sherad/network/remote/api_manager.dart';

import '../Screens/categoriesScreen.dart';
import '../Screens/drawer.dart';
import '../home/news_screen.dart';
import '../Screens/tabs.dart';
import '../model/categoryModel.dart';

class Home_screen extends StatefulWidget {
  static const String routeName = "Home screen";

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isSearch ? null : DrawerWidget(onDrawerClick),
      appBar: AppBar(
        actions: !isSearch
            ? categoryModel != null
                ? [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                          onTap: () {
                            // showSearch(context: context, delegate: NewsSearch());
                            setState(() {
                              isSearch = true;
                            });
                          },
                          child: Icon(
                            Icons.search,
                            size: 30,
                          )),
                    )
                  ]
                : null
            : null,
        title: isSearch
            ? Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextField(
                  controller: controller,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                  decoration: InputDecoration(
                      hintText: "Search......",
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isSearch = false;
                              controller.clear();
                            });
                          },
                          icon: Icon(Icons.clear)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isSearch = true;
                            });
                          },
                          icon: Icon(Icons.search)),
                      border: OutlineInputBorder(
                        // borderSide:BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              )
            : Text(categoryModel == null ? "News App" : categoryModel!.name),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.horizontal(
              right: Radius.circular(20), left: Radius.circular(20)),
        ),
        elevation: 0,
      ),
      body: categoryModel == null
          ? CategoriesScreen(onCategorySelect)
          : NewsScreen(
              categoryModel!,
        controller.text
            ),
    );
  }

  CategoryModel? categoryModel = null;

  void onDrawerClick(number) {
    if (number == DrawerWidget.category) {
      categoryModel = null;
    } else if (number == DrawerWidget.setting) {}
    setState(() {
      Navigator.pop(context);
    });
  }

  void onCategorySelect(category) {
    categoryModel = category;
    setState(() {});
  }
}

class NewsSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: ApiMngment.getData(q: query),
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
        var news = snapshot.data?.articles ?? [];
        return ListView.builder(
          itemBuilder: (context, index) {
            return NewsItems(news[index]);
          },
          itemCount: news.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Suggestion"),
    );
  }
}
