import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/Screens/web_view_screen.dart';
import 'package:news/model/NewsModel.dart';

import '../home/news_screen.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = "DetailsScreen";
  @override
  Widget build(BuildContext context) {
    var articles = ModalRoute.of(context)?.settings.arguments as Articles;
    return Scaffold(
      appBar: AppBar(
        title: Text(articles.title ?? ""),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.horizontal(
              right: Radius.circular(20), left: Radius.circular(20)),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: articles.urlToImage ?? "",
                height: 200,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Text(
                articles.source?.name ?? "",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                articles.title ?? "",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                articles.author ?? "",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    articles.publishedAt!.substring(0, 10),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20
              ),
              Text(
                articles.description ?? "",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, WebViewScreen.routeName,arguments: articles);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("View Full Article", style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,),),
                    SizedBox(width: 20,),
                    Icon(Icons.arrow_forward_sharp)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
