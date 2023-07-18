import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/categoryModel.dart';

class CateggoryItem extends StatelessWidget {
  CategoryModel categoryModel;
  int index = 0;

  CateggoryItem(this.categoryModel, this.index);

  // color: categoryModel.color,
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: categoryModel.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
              bottomRight: index.isOdd?Radius.circular(45):Radius.zero,
              bottomLeft: index.isEven?Radius.circular(45):Radius.zero,

            )),
        child: Column(
          children: [
            Image.asset(
              categoryModel.image,
              height: 90,
            ),
            Text(
              categoryModel.name,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
