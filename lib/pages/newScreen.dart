import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/slider_model.dart';
import '../models/article_model.dart';
import '../services/news.dart';
import '../services/slider_data.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  News newsProvider = News();
  Sliders slidersProvider = Sliders();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await newsProvider.getNews();
    await slidersProvider.getSlider();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  'Breaking News',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              _buildSlider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Trending News',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              _buildNewsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Container(
      height: 200.0,
      child: CarouselSlider.builder(
        itemCount: slidersProvider.sliders.length,
        itemBuilder: (context, index, realIndex) {
          sliderModel slider = slidersProvider.sliders[index];
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    slider.urlToImage ?? '',
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        slider.title ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return Column(
      children: newsProvider.news.map((article) {
        bool isImageAvailable =
            article.urlToImage != null && article.urlToImage!.isNotEmpty;

        return Card(
          color: Colors.black,
          elevation: 10.0,
          margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      image: isImageAvailable
                          ? DecorationImage(
                              image: NetworkImage(article.urlToImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: isImageAvailable
                        ? null
                        : Center(
                            child: Icon(
                              Icons.image,
                              size: 10000.0,
                              color: Colors.grey[600],
                            ),
                          ),
                  ),
                  isImageAvailable
                      ? Container(
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        article.title ?? '',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Container(
                      height: 1.0,
                      width: 1000.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      article.description ?? '',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
