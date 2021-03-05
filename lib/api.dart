import 'dart:convert';

import 'package:http/http.dart' as http;
import 'model.dart';

const String apiUrl = 'https://newsapi.org/v2/top-headlines?' +
    'country=us&' +
    'apiKey=f599cb8706914e578b866c0d0dc58a4f';

Future<List<NewsModel>> getNews() async {
  var reponse = await http.get(apiUrl).catchError((error) {
    print(error.toString());
  });
  var data = jsonDecode(reponse.body);
  List<NewsModel> news = [];
  List l = data['articles'];
  l.forEach((element) {
    news.add(NewsModel.fromMap(element));
  });
  print(reponse.body);
  return news;
}
