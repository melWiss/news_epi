class NewsModel {
  String url;
  String title;
  String imgUrl;
  String description;

  NewsModel({this.description, this.imgUrl, this.title, this.url});

  NewsModel.fromMap(Map<String, dynamic> map) {
    this.url = map['url'];
    this.description = map['description'];
    this.title = map['title'];
    this.imgUrl = map['urlToImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'url': this.url,
      'urlToImage': this.imgUrl,
    };
  }
}
