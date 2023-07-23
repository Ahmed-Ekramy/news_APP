import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Screens/widget/categoryItem.dart';
import 'package:news/model/categoryModel.dart';

class CategoriesScreen extends StatelessWidget {
var category=CategoryModel.getCategory();
    Function onCategorySelect;

CategoriesScreen(this.onCategorySelect);

@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Pick your category of interest",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20,),
        Expanded(
          child: GridView.builder(
            itemCount: category.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 24,mainAxisSpacing: 24),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      onCategorySelect(category[index]);
                    },
                    child: CateggoryItem(category[index],index));
              },),
        )
      ],
    );
  }}
