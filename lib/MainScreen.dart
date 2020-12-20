import 'dart:convert';

import 'package:book_store/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'Book.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookList;
  double screenHeight, screenWidth;
  String title = 'No Data Found';

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  _loadBooks() {
    print("Load Restaurant Data");
    http.post("http://slumberjer.com/bookdepo/php/load_books.php",
        body: {}).then((res) {
      print(res.body);

      if (res.body == "nodata") {
        bookList = null;
      } else {
        setState(() {
          var jsondata = json.decode(res.body); //decode json data

          bookList = jsondata["books"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadDetailScreen(int index) {
    Book book = new Book(
      bookID: bookList[index]['bookid'],
      bookTitle: bookList[index]['booktitle'],
      author: bookList[index]['author'],
      price: bookList[index]['price'],
      description: bookList[index]['description'],
      rating: bookList[index]['rating'],
      publicher: bookList[index]['publisher'],
      ISBN: bookList[index]['isbn'],
      cover: bookList[index]['cover'],
    );

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DetailScreen(book),
    ));
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Book list'),
        ),
        body: Column(
          children: [
            bookList == null
                ? Flexible(
                    child: Container(
                        child: Center(
                            child: Text(title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )))))
                : Flexible(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth/screenHeight)/0.65,
                      children: List.generate(bookList.length,(index) {
                          return Padding(
                              padding: EdgeInsets.all(2),
                              child: Card(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _loadDetailScreen(index);
                                  });
                                },
                                child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(bookList[index]['booktitle'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(height:5),
                                    Container(
                                        height: 110,
                                        width: 80,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://slumberjer.com/bookdepo/bookcover/${bookList[index]['cover']}.jpg",
                                             // fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                            Icons.broken_image,
                                            size: screenWidth / 2,
                                          ),
                                        )),
                                        SizedBox(height:10),
                                    Text("RM " + bookList[index]['price'],
                                        textAlign: TextAlign.center),
                                    Text("Author: " + bookList[index]['author'],
                                        textAlign: TextAlign.center),
                                    Text("Rating: " + bookList[index]['rating'],
                                        textAlign: TextAlign.center),
                                  ],
                                )),
                              )));
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
