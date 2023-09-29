import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/slider_model.dart';

class Sliders {
  List<sliderModel> sliders = [];

  Future<void> getSlider() async {
    String url =
        "https://newsapi.org/v2/everything?q=apple&from=2023-09-28&to=2023-09-28&sortBy=popularity&apiKey=6cf4a16c50d043d791a16bf34a073c63";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Slider Response: ${response.statusCode}');
        print('Slider Response Body: ${response.body}');

        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((element) {
            if (element["urlToImage"] != null &&
                element['description'] != null) {
              sliderModel slidermodel = sliderModel(
                title: element["title"],
                description: element['description'],
                url: element["url"],
                urlToImage: element["urlToImage"],
                content: element["content"],
                author: element["author"],
              );
              sliders.add(slidermodel);
            }
          });
        }
      } else {
        print('Slider Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching slider data: $e');
    }
  }
}
