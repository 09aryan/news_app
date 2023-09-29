import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=apple&from=2023-09-28&to=2023-09-28&sortBy=popularity&apiKey=6cf4a16c50d043d791a16bf34a073c63";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('News Response: ${response.statusCode}');
        print('News Response Body: ${response.body}');

        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((element) {
            if (element["urlToImage"] != null &&
                element['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                title: element['title'],
                description: element["description"],
                url: element["url"],
                urlToImage: element["urlToImage"],
                content: element["content"],
                author: element["author"],
              );
              news.add(articleModel);
            }
          });
        }
      } else {
        print('News Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news data: $e');
    }
  }
}
