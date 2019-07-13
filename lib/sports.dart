// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class sports extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return (sportsNews());
  }
}

class sportsNews extends State<sports>{

  final String surl="https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=bd154fff71364858be79083b11554ed8";
  List sports;
  void initState(){
    super.initState();
    this.getsports();
  }

  Future<String> getsports() async {
    var response = await http.get(
        Uri.parse(surl), headers: {'Accept': 'application/json'});
    setState(() {
      var res = json.decode(response.body);
      sports=res['articles'];
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
                  itemCount: sports==null ? 0 : sports.length,
                  itemBuilder:(BuildContext context,int index){
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: Image.network(
                                sports[index]['urlToImage'],
                              fit: BoxFit.cover,
                            ),

                            margin: EdgeInsets.all(10.0),
                          ),
                          ListTile(
                            title: Text(sports[index]['title'],style: TextStyle(fontWeight: FontWeight.bold),),
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> (new spnews(sports,index) ))),
                          )
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

class spnews extends StatelessWidget{
  List sports;
  int index;

  spnews(this.sports,this.index);
  Widget build(BuildContext context){
    return Scaffold(
    appBar:AppBar(
    title: Text('Sports News'),
      backgroundColor: Colors.deepPurpleAccent,
    ),
        body:sdesc(),
    );
}
Widget sdesc(){
  if(sports[index]['content'] == null) {
    sports[index]['content'] = sports[index]['description'];
  }
    else{
      sports[index]['content']=sports[index]['content'];
    }

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 400.0,
            height: 300.0,
            child: Image.network(sports[index]['urlToImage']),
          ),
          Text(sports[index]['content'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
        ],
      ),
    );
}
}