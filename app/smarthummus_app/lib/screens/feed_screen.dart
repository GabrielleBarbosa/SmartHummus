import 'dart:convert';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:smarthummusapp/cards/feed_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';
import 'file:///C:/Users/DELL/Documents/GitHub/SmartHummus/app/smarthummus_app/lib/database/news_article.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  Future<List<NewsArticle>> _newsArticles;
  int _page = 0;
  bool _disabled = false;
  Future<void> _launched;
  Future<String> _username;

  @override
  void initState() {
    super.initState();
    _username = Database.getUsername();
    _newsArticles = fetchNewsArticle();
  }

  Future<List<NewsArticle>> fetchNewsArticle() async {

    final response = await http.get('https://newsapi.org/v2/everything?q=sustentabilidade&apiKey=e6914ff243274c6a8b3a8362395a3ab6&language=pt&domains=globo.com,uol.com.br&sortBy=publishedAt');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<NewsArticle> list = List();
      var decoded = jsonDecode(response.body)['articles'];

      for(var a in decoded){
        list.add(NewsArticle.fromJson(a));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load measures');
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  GestureDetector _buildItemsForListView(BuildContext context, int index, List<NewsArticle> newsArticle){
    return
      GestureDetector(
        onTap: () => setState(() {
          _launched = _launchInBrowser(newsArticle[index].url);
        }),
        child: FeedCard(newsArticle[index].title, newsArticle[index].description, newsArticle[index].urlToImage, newsArticle[index].content.split('[')[0]),
      );
  }

  GestureDetector _buildItems(BuildContext context, NewsArticle newsArticle){
    return
      GestureDetector(
        onTap: () => setState(() {
          _launched = _launchInBrowser(newsArticle.url);
        }),
        child: FeedCard(newsArticle.title, newsArticle.description, newsArticle.urlToImage, newsArticle.content.split('[')[0]),
      );
  }

  /*void _decreasePage(){
    setState(() {
      _page--;
      _disabled = false;
    });
  }

  void _increasePage(){
    if(_newsArticles.length>=(_page+1)*10+10){
      if(_newsArticles.length>=(_page+2)*10+9){
        setState(() {
          _page++;
        });
      }
      else{
        setState(() {
          setState(() {
            _page++;
            _disabled = true;
          });
        });
      }
    }
    else{
      _disabled = true;
    }
  }
*/

  Widget _cabecalho(){
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          height: 180,
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(55.0),
                bottomLeft: Radius.circular(55.0),
              ),
              child: Container(
                color: Color.fromRGBO(17, 204, 199, 83.0),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 70.0, left: 35.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "OLÁ,",
                                  style: GoogleFonts.raleway(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            FutureBuilder<String>(
                              future: _username,
                              builder: (context, snapshot){
                                if(snapshot.hasData){
                                  return Row(
                                    children: [
                                      Text(
                                        (snapshot.data.split(' ')[0]).toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  );
                                }
                                return Container();
                              },
                            )
                          ])),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Image(
                    image: AssetImage('assets/images/folhas.png'),
                    fit: BoxFit.cover,
                    width: 230,)
                ]),
              ),
            ),
          ),
        ),
        /*Row(
          children: [
            RaisedButton(
              child: Text("Anterior"),
              onPressed: _page>0?_decreasePage: null,
            ),
            RaisedButton(
              child: Text("Próxima"),
              onPressed: _disabled?null:_increasePage,
            ),
          ],
        ),*/

        Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Text(
              "FEED",
              style: GoogleFonts.raleway(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(55, 55, 55, 100.0)
              ),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _cabecalho(),
          FutureBuilder<List<NewsArticle>>(
            future: _newsArticles,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  children:
                  snapshot.data.map<Widget>((NewsArticle n){
                    return _buildItems(context, n);
                  }).toList()
                  ,
                );
              }

              else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );

  }
}

