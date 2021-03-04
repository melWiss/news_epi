import 'package:flutter/material.dart';
import 'package:news_epi/model.dart';

import 'details.dart';

class NewsCard extends StatelessWidget {
  final NewsModel newsModel;

  NewsCard({this.newsModel});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewsDetails(
                description: newsModel.description,
                title: newsModel.title,
                imageUrl: newsModel.imgUrl,
              );
            },
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(newsModel.imgUrl),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.pink,
                      child: Text(
                        newsModel.title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                newsModel.description,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
