// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class Tech extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return (techNews());
  }
}

class techNews extends State<Tech>{

  final String turl="https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=bd154fff71364858be79083b11554ed8";
  List tech;
  void initState(){
    super.initState();
    this.TechNews();
  }

  Future<String> TechNews() async {
    var response = await http.get(
        Uri.parse(turl), headers: {'Accept': 'application/json'});
    setState(() {
      var res = json.decode(response.body);
      tech=res['articles'];
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
                  itemCount: tech==null ? 0 : tech.length,
                  itemBuilder:(BuildContext context,int index){
                    return Container(
                      child: Column(

                        children: <Widget>[

                          Card(

                            child: Image.network(

                              tech[index]['urlToImage'],
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
                            title: Text(tech[index]['title'],style: TextStyle(fontWeight: FontWeight.bold)),
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> (new tenews(tech,index) ))),
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

class tenews extends StatelessWidget{
  List tech;
  int index;

  tenews(this.tech,this.index);
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: Text('Technical News'),
        backgroundColor: Colors.green,
      ),
      body:sdesc(),
    );
  }
  Widget sdesc(){

    if(tech[index]['content'] == null) {
      tech[index]['content'] = tech[index]['description'];
    }
    else{
      tech[index]['content']=tech[index]['content'];
    }

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 400.0,
            height: 300.0,
            child: Image.network(tech[index]['urlToImage']),
          ),
          Text(tech[index]['content'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),

        ],
      ),
    );
  }
}