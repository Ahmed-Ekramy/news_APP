import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/model/Sourse%20respons.dart';

class tabItems extends StatelessWidget {
  Sources sources;
  bool selected;

  tabItems(this.sources, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.green,width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          textAlign:TextAlign.center,
          sources.name ?? "",
          style: TextStyle(
              color: selected ? Colors.white : Colors.green, fontSize: 14),
        ),
      ),
    );
  }
}
