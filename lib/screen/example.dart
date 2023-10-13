import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
List<Photo>photolist=[];

Future<List<Photo>> getPhotoApi()async{
  final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  var data= jsonDecode(response.body.toString());
  if(response.statusCode == 200){
    for(Map i in data){
      Photo photos=Photo(title: i['title'], url: i['url'],id: i['id']);
      photolist.add(photos);
    }
    return photolist;
  }else{
    return  photolist;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Center(child: Text('Example Api Page')),
      ),
      body: Column(
        children: [
            Expanded(
              child: FutureBuilder(
                  future: getPhotoApi(),

                  /// snapshot ar vitor image rakha hoilo
                  builder:(context, AsyncSnapshot <List<Photo>>snapshot) {
                 return  ListView.builder(
                     itemCount: photolist.length,
                     itemBuilder: (context,index){
                     return ListTile(
                       leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                       ),
                       title: Text(' Notes ' + snapshot.data![index].id.toString()),///snapshot theke call kra hoilo
                     subtitle:Text( snapshot.data![index].title.toString()) ,
                     );
                   });
                 }
                  ),
            ),

        ],
      ),
    );
  }
}


class Photo{
  String title , url;
  int id;
  Photo({ required this.title,required this.url,required this.id});
}
