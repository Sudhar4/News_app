// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class all extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return (allNews());
  }
}

class allNews extends State<all>{

  final String url="https://newsapi.org/v2/top-headlines?country=in&apiKey=bd154fff71364858be79083b11554ed8";
  List news;
  void initState(){
    super.initState();
    this.getNews();
  }

  Future<String> getNews() async {
    var response = await http.get(
        Uri.parse(url), headers: {'Accept': 'application/json'});
    setState(() {
      var res = json.decode(response.body);
      news=res['articles'];
    });
    return 'success';
  }



  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Flexible(
              child: ListView.builder(
                  itemCount: news==null ? 0 : news.length,
                  itemBuilder:(BuildContext context,int index){
                   return Container(
                     child: Column(
                       
                       children: <Widget>[
                         
                         Card(


                           child: Image.network(

                             news[index]['urlToImage'],
                             fit: BoxFit.cover,


                                 
                           ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ) ,
                        /* shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0)
                         ) */
                          // elevation: 3,
                           margin: EdgeInsets.all(10),
                         ),
                         ListTile(
                           title: Text(news[index]['title'],style: TextStyle(fontWeight: FontWeight.bold),),
                           onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => (new snews(news,index)))),
                         ),

                       ],
                     ),
                   );


                  }
              )
          )
        ],
      ),
    );
  }
}

@override
class snews extends StatelessWidget{
  List news;
  int index;
  snews(this.news,this.index);
  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('All News'),
        backgroundColor: Colors.pink,
      ),
      body:desc(context),
    );
  }
  Widget desc(BuildContext context){
    if(news[index]['content']==null){
      news[index]['content']=news[index]['description'];
    }
    else{
      news[index]['content']=news[index]['content'];
    }
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            width:400.0,
            height:300.0,
              child:Image.network(news[index]['urlToImage'])
          ),
          Text(news[index]['content'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal),),
         /* new GestureDetector(
            child: Text(news[index]['url']),
            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> (new urlAll(news,index)))),
          )*/
        ],
      ),
    );
  }
}

