import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Screens/widget/newsItem.dart';
import 'package:news/home/cubit/cubit.dart';
import 'package:news/sherad/network/remote/api_manager.dart';

import '../Screens/categoriesScreen.dart';
import '../Screens/drawer.dart';
import '../home/cubit/state.dart';
import '../home/news_screen.dart';
import '../Screens/tabs.dart';
import '../model/categoryModel.dart';

class Home_screen extends StatelessWidget {
  static const String routeName = "Home screen";


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
     BlocBuilder<HomeCubit,HomeState>(
       builder: (context, state) {
         return
           Scaffold(
             drawer: HomeCubit
                 .get(context)
                 .isSearch ? null : DrawerWidget(HomeCubit
                 .get(context)
                 .onDrawerClick),
             appBar: AppBar(
               actions: !HomeCubit
                   .get(context)
                   .isSearch
                   ? HomeCubit
                   .get(context)
                   .categoryModel != null
                   ? [
                 Padding(
                   padding: EdgeInsets.all(16),
                   child: InkWell(
                       onTap: () {
                         // showSearch(context: context, delegate: NewsSearch());
                         HomeCubit
                             .get(context)
                            .OnSearch();
                       },
                       child: const Icon(
                         Icons.search,
                         size: 30,
                       )),
                 )
               ]
                   : null
                   : null,
               title: HomeCubit
                   .get(context)
                   .isSearch
                   ? Container(
                 width: MediaQuery
                     .of(context)
                     .size
                     .width * 0.8,
                 height: MediaQuery
                     .of(context)
                     .size
                     .height * 0.1,
                 child: TextField(
                   controller: controller,
                   style: TextStyle(fontSize: 20, color: Colors.grey),
                   decoration: InputDecoration(
                       hintText: "Search......",
                       fillColor: Colors.white,
                       filled: true,
                       prefixIcon: IconButton(
                           onPressed: () {
                             HomeCubit
                                 .get(context)
                                .OnSearch();
                             controller.clear();
                           },
                           icon: Icon(Icons.clear)),
                       suffixIcon: IconButton(
                           onPressed: () {
                           HomeCubit.get(context).getData(q:controller.text);
                           },
                           icon: Icon(Icons.search)),
                       border: OutlineInputBorder(
                         // borderSide:BorderSide(color: Colors.white),
                         borderRadius: BorderRadius.circular(30),
                       )),
                 ),
               )
                   : Text(HomeCubit
                   .get(context)
                   .categoryModel == null ? "News App" : HomeCubit
                   .get(context)
                   .categoryModel!
                   .name),
               centerTitle: true,
               backgroundColor: Colors.green,
               shape: const OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.horizontal(
                     right: Radius.circular(20), left: Radius.circular(20)),
               ),
               elevation: 0,
             ),
             body: HomeCubit
                 .get(context)
                 .categoryModel == null
                 ? CategoriesScreen(HomeCubit
                 .get(context)
                 .onCategorySelect)
                 : NewsScreen(
                 HomeCubit
                     .get(context)
                     .categoryModel!,
                 controller.text
             ),

           );
       }
     );
  }

  // CategoryModel? categoryModel = null;
  //
  // void onDrawerClick(number) {
  //   if (number == DrawerWidget.category) {
  //     categoryModel = null;
  //   } else if (number == DrawerWidget.setting) {}
  //   setState(() {
  //     Navigator.pop(context);
  //   });
  // }
  //
  // void onCategorySelect(category) {
  //   categoryModel = category;
  //   setState(() {});
  // }
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
    return
      BlocConsumer(listener: (context, state)
    {
      if (state is HomeGetNewsLoadingState ||
        state is HomeGetSourceLoadingState) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
      } else if (state is HomeGetSourceSuccessState) {} else
      if (state is HomeGetSourceErrorState) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(state.error),
          );
        },
      );
      } else if (state is HomeGetNewsSuccessState) {} else
      if (state is HomeGetNewsErrorState) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(state.error),
          );
        },
      );
      }
    },
    builder: (context, state) {
      return ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItems(HomeCubit.get(context).news[index]);
                },
                itemCount: HomeCubit.get(context).news.length,
              );
    }

  );

  }

  //
  //     FutureBuilder(
  //     future: ApiMngment.getData(q: query),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator();
  //       }
  //       if (snapshot.hasError) {
  //         return Column(
  //           children: [
  //             Text("Somting went wrong"),
  //             TextButton(onPressed: () {}, child: Text("Try Agin"))
  //           ],
  //         );
  //       }
  //       if (snapshot.data?.status != "ok") {
  //         print(snapshot.data?.status);
  //         return Column(
  //           children: [
  //             Text("Erorr!!"),
  //             TextButton(onPressed: () {}, child: Text("Try Agin"))
  //           ],
  //         );
  //       }
  //       var news = snapshot.data?.articles ?? [];
  //       return ListView.builder(
  //         itemBuilder: (context, index) {
  //           return NewsItems(news[index]);
  //         },
  //         itemCount: news.length,
  //       );
  //     },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Suggestion"),
    );
  }
}
