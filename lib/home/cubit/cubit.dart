import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/home/cubit/state.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../Screens/drawer.dart';
import '../../model/NewsModel.dart';
import '../../model/Sourse respons.dart';
import '../../model/categoryModel.dart';
import '../../sherad/componant/constant.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<Sources> sources = [];
  List<Articles> news = [];
  int selectedInex = 0;
  String? query;
  CategoryModel? categoryModel;
  bool isSearch = false;
  void changeSource(int index){
    selectedInex=index;
    emit(HomeChangeSource());
  }
  Future<void> getSources(String catId) async {
    Uri URL = Uri.https(BASE, "/v2/top-headlines/sources",
        {"apiKey": ApiKey, "category": catId});
    emit(HomeGetSourceLoadingState());
    http.get(URL).then((value) {
      var JasonResponse = jsonDecode(value.body);
      SourcesRespons sourcesResponse = SourcesRespons.fromJson(JasonResponse);
      sources = sourcesResponse.sources ?? [];
      emit(HomeGetSourceSuccessState());
    }).catchError((error) {
      emit(HomeGetSourceErrorState(error));
    });
  }

  Future<void> getData({ String? q}) async {
    Uri URL = Uri.https(BASE, "/v2/everything",
        {"apiKey": ApiKey, "sources": sources[selectedInex].id  , "q": q});
    emit(HomeGetNewsLoadingState());
    http.get(URL).then((value) {
      var json = jsonDecode(value.body);
      print(value.body);
      NewsModel newsModel = NewsModel.fromJson(json);
      news =newsModel.articles ?? [] ;
      emit(HomeGetNewsSuccessState());
    }).catchError((error){
      emit(HomeGetNewsErrorState(error));
    });
  }

  void onDrawerClick(number) {
    if (number == DrawerWidget.category) {
      categoryModel = null;
    } else if (number == DrawerWidget.setting) {}
      // Navigator.pop(context);
    emit(HomeOnDrawerClickState());
  }

  void onCategorySelect(category) {
    categoryModel = category;
emit(HomeOnCategorySelectState());
  } void OnSearch() {
    isSearch=!isSearch;
emit(HomeOnSearch());
  }
}
