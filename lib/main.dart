import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
void main() {
  runApp(MaterialApp(
    home:  new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url ="https://stark-spire-93433.herokuapp.com/json";
  late List data =[] ;
  var loading =false;

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
    this.getJsonData();
    // User reated Method to get data in future
  }
  Future<String> getJsonData() async{
    var respoonse = await http.get(Uri.parse(url),//encode url
        headers: {"Accept":"application/json"} //only aCCEPT json response
    );
    print(respoonse.body);
    setState(() {
      var convertDataToJson = jsonDecode(respoonse.body);
      data = convertDataToJson['categories'];
      // Products productsdetail = data.products;
      //  data =_list;
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Retrive Json via http"),
      ),
      body: Container(
        child: new ListView.builder(
            itemCount: data == null ?0 : data.length,
            itemBuilder: (BuildContext context,int index){
              return new Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      new Card(
                        child: ListTile(
                          title: new Text(data[index]['id'].toString()),
                          subtitle: new Text(data[index]['name']) ,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

