import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/model/NewsModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsItems extends StatelessWidget {
  Articles article;

  NewsItems(this.article);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(14),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.transparent)),
      elevation: 16,
      child:  Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: article.urlToImage??"",
              height: 200,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(
              article.title ?? "",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 10,),
            Text(
              article.description ?? "",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              article.author ?? "",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 14,),
            Text(article.publishedAt!.substring(0, 10),
              textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                ),
          ],
        ),
      ),
    );
  }
}
