import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  Color color;

  CategoryModel(this.id, this.name, this.image, this.color);

  static List<CategoryModel> getCategory() {
    return [
      CategoryModel("business", "Business", "assets/images/bussines.png",
          Color(0xffCF7E48)),
      CategoryModel(
          "sports", "Sports","assets/images/sports.png", Color(0xffC91C22)),
      CategoryModel(
          "science", "Science", "assets/images/science.png", Color(0xffF2D352)),
      CategoryModel(
          "health", "Health", "assets/images/health.png", Color(0xffED1E79)),
      CategoryModel(
          "general", "General", "assets/images/Politics.png", Color(0xffF2D352)),
      CategoryModel("technology", "technology", "assets/images/bussines.png",
          Color(0xffCF7E48)),
      CategoryModel("entertainment", "Entertainment",
          "assets/images/environment.png", Color(0xff4882CF)),
    ];
  }
}
