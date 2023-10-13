import 'dart:convert';
import 'package:api/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../style/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModel> postLists=[];
  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var data= jsonDecode(response.body.toString());
    if(response.statusCode ==200){
      for(Map i in data){
        postLists.add(PostModel.fromJson(i));

      }
      return postLists;
    }else{
      return postLists;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(" Rest API")),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Text('Loading ...');
                  }else
                    {
                      return ListView.builder(
                        itemCount: postLists.length,
                          itemBuilder:(context,index){
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Text('Title',style: AppStyle()),
                                  Text(postLists[index].title.toString()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Description',style: AppStyle()),
                                  Text(postLists[index].body.toString()),
                                ],
                              ),
                            ),
                          );
                          });
                    }
                }),
          )
        ],
      ),

    );
  }
}
