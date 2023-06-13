import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/sherad/componant/constant.dart';

import '../../../model/Sourse respons.dart';

class ApiMngment {
  static Future<SourcesRespons> getSources() async {
    Uri URL = Uri.https(BASE, "/v2/top-headlines/sources",
        {"apiKey": ApiKey});
    http.Response respons= await http.get(URL);
    var JasonRespons=jsonDecode(respons.body);
    SourcesRespons sourcesRespons=SourcesRespons.fromJson(JasonRespons);
    return sourcesRespons;
  }
}
