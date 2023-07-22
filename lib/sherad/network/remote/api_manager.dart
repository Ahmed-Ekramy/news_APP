import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news/model/NewsModel.dart';
import 'package:news/sherad/componant/constant.dart';

import '../../../model/Sourse respons.dart';

class ApiMngment {
  static Future<SourcesRespons> getSources(String catId) async {
    Uri URL = Uri.https(BASE, "/v2/top-headlines/sources",
        {"apiKey": ApiKey,"category":catId});
    http.Response respons= await http.get(URL);
    var JasonRespons=jsonDecode(respons.body);
    SourcesRespons sourcesRespons=SourcesRespons.fromJson(JasonRespons);
    return sourcesRespons;
  }
 static Future<NewsModel> getData ({String? sourceId, String? q}) async {
    Uri URL=Uri.https(BASE,"/v2/everything",{"apiKey":ApiKey,"sources":sourceId,"q":q});
    Response response= await http.get(URL);
    var  json=jsonDecode(response.body);
    NewsModel newsModel=NewsModel.fromJson(json);
    return newsModel;
  }
}
