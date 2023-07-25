import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Screens/widget/newsItem.dart';
import 'package:news/Screens/widget/tab_item.dart';
import 'package:news/home/cubit/cubit.dart';
import 'package:news/sherad/network/remote/api_manager.dart';
import '../model/Sourse respons.dart';

class tabsScreen extends StatelessWidget {
  List<Sources> sources;
  String query;

  tabsScreen(this.sources, this.query,);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTabController(
              length: sources.length,
              child: TabBar(
                onTap: (value) {
                  HomeCubit.get(context).changeSource(value);
                },
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: sources
                    .map((source) =>
                    Tab(
                        child: tabItems(source,
                            sources.indexOf(source) == HomeCubit
                                .get(context)
                                .selectedInex)))
                    .toList(),
              )),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return NewsItems(HomeCubit
                  .get(context)
                  .news[index]);
            },
            itemCount: HomeCubit
                .get(context)
                .news
                .length,
          ),
        )
        // FutureBuilder(
        //   future: ApiMngment.getData(
        //       sourceId: widget.sources[selectedInex].id ?? "",q:widget.query),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return CircularProgressIndicator();
        //     }
        //     if (snapshot.hasError) {
        //       return Column(
        //         children: [
        //           Text("Somting went wrong"),
        //           TextButton(onPressed: () {}, child: Text("Try Agin"))
        //         ],
        //       );
        //     }
        //     if (snapshot.data?.status != "ok") {
        //       print(snapshot.data?.status);
        //       return Column(
        //         children: [
        //           Text("Erorr!!"),
        //           TextButton(onPressed: () {}, child: Text("Try Agin"))
        //         ],
        //       );
        //     }
        //     var news = snapshot.data?.articles ?? [];
        //     return Expanded(
        //       child: ListView.builder(
        //         itemBuilder: (context, index) {
        //           return NewsItems(news[index]);
        //         },
        //         itemCount: news.length,
        //       ),
        //     );
        //   },
        // )
      ],
    );
  }

}
