import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.7,
      color: Colors.white,
      child: Column(

        crossAxisAlignment:  CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(60.0),
              color:  Colors.green,
              child: Text("News App!",style: TextStyle(fontSize: 24),),
           ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.list_outlined,size: 30,),
                SizedBox(width: 20,),
                Text("Categories",style: TextStyle(fontSize: 24),),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.settings,size: 30,),
                SizedBox(width: 20,),
                Text("Settings",style: TextStyle(fontSize: 24),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}