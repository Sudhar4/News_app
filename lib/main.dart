import 'package:flutter/material.dart';
import 'package:news_app/all.dart';
import 'package:news_app/sports.dart';
import 'package:news_app/tech.dart';
void main(){
  runApp(base());
}

class base extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData.dark(),

      home:DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(

             // leading: Icon(Icons.book),
              bottom: TabBar(
                labelColor: Colors.green,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    new Tab(text:'All'),
                    new Tab(text:'Sports'),
                    new Tab(text:'Tech'),

                  ],
                      //labelColor: Colors.black87,
                indicatorColor: Colors.white,
              ),

              title:Text('News App',style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.transparent,
              
            ),

            body: TabBarView(
                children:[
                  new all(),
                  new sports(),
                  new Tech(),
                ]
            )
            ,
          )

      ),

    );
  }
}