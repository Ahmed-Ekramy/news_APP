
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Screens/newsItem.dart';
import 'package:news/sherad/network/remote/api_manager.dart';

import '../model/Sourse respons.dart';
import '../widget/tab_item.dart';

class tabsScreen extends StatefulWidget {
  List<Sources> sources;

  tabsScreen(this.sources);

  @override
  State<tabsScreen> createState() => _tabsScreenState();
}

class _tabsScreenState extends State<tabsScreen> {
  int selectedInex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTabController(
              length: widget.sources.length,
              child: TabBar(
                onTap: (value) {
                  selectedInex = value;
                  setState(() {});
                },
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: widget.sources
                    .map((source) => Tab(
                        child: tabItems(source,
                            widget.sources.indexOf(source) == selectedInex)))
                    .toList(),
              )),
        ),
        FutureBuilder(
          future: ApiMngment.getData(widget.sources[selectedInex].id?? ""),
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
            return Expanded(
              child: ListView.builder( itemBuilder: (context, index) {
                return NewsItems(news[index]);
              },itemCount: news.length,),
            );
          },
        )
      ],
    );
  }
}
