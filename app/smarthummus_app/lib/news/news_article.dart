import 'dart:convert';

import 'package:smarthummusapp/news/web_service.dart';

class NewsArticle {

  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String content;

  NewsArticle({this.title, this.description, this.urlToImage, this.url, this.content});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
        title: json['title'],
        description: json['description'],
        urlToImage: json['urlToImage'],
        url: json['url'],
        content: json['content']
    );
  }

  static Resource<List<NewsArticle>> get all {

    return Resource(
        url: "https://newsapi.org/v2/everything?q=sustentabilidade&apiKey=e6914ff243274c6a8b3a8362395a3ab6&language=pt&domains=globo.com,uol.com.br&sortBy=publishedAt",
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['articles'];
          return list.map((model) => NewsArticle.fromJson(model)).toList();
        }
    );

  }

}