import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  NewsDetails({this.title, this.imageUrl, this.description});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(color: Colors.blue),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Card(
            child: Image.network(imageUrl),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(description),
          ),
          OutlinedButton(
            child: Text('Open this article'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
