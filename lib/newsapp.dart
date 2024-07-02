import 'dart:convert';
import 'newsmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  Future<News> fetchNews()async{
    final url="https://newsapi.org/v2/everything?q=tesla&from=2024-06-02&sortBy=publishedAt&apiKey=2ee0144301b5481ca6d540104bccecc8";
    var response=await http.get(Uri.parse(url)); 
    if(response.statusCode==200){
      final result=jsonDecode(response.body);
      return News.fromJson(result);
    }else{
      return News();
    }
  }

@override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("News"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(future: fetchNews(), builder:(context,snapshot) {
        return ListView.builder(itemBuilder: (context,index){
          return ListTile(
            leading:CircleAvatar(
              backgroundImage: NetworkImage("${snapshot.data!.articles![index].urlToImage}"),
            ),
            title: Text("${snapshot.data!.articles![index].title}"),
            subtitle: Text("${snapshot.data!.articles![index].description}"),
        );
        },
        itemCount: snapshot.data!.articles!.length);
      }
      ),
      );
      }
  }