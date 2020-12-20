import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'Book.dart';

class DetailScreen extends StatefulWidget {
  final Book selectedBook;

  DetailScreen(this.selectedBook);

  @override
  _DetailScreenState createState() => _DetailScreenState(selectedBook);
}

class _DetailScreenState extends State<DetailScreen> {
  Book book;
  double screenHeight, screenWidth;

  _DetailScreenState(Book selectedBook);

  @override
  void initState() {
    super.initState();
    book = widget.selectedBook;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Book Details'),
        ),
        body:SingleChildScrollView(child:Column(      
          children: [
        SizedBox(height:10),
        Text(book.bookTitle, textAlign: TextAlign.center, style: TextStyle(
          fontSize:25, fontWeight: FontWeight.bold),),
        SizedBox(height:10),
        Container(
            height: 300,
            width: 190,
            child: CachedNetworkImage(
              imageUrl:
                  "http://slumberjer.com/bookdepo/bookcover/${book.cover}.jpg",
              fit: BoxFit.cover,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(
                Icons.broken_image,
                size: screenWidth / 2,
              ),
            )),
            
        Text("Price: ", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        Text("RM " + book.price, textAlign: TextAlign.center),
        SizedBox(height: 7),
        Text("Description: ", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        Text(book.description, textAlign: TextAlign.center),
        SizedBox(height: 7),
        Text("Author: ", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        Text(book.author, textAlign: TextAlign.center),
        SizedBox(height: 7),
        Text("Rating: ", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        Text(book.rating, textAlign: TextAlign.center),
        SizedBox(height: 7),
        Text("Publisher: ", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        Text(book.publicher, textAlign: TextAlign.center),
        SizedBox(height: 7),
        Text("ISBN: ", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        Text(book.ISBN, textAlign: TextAlign.center),
      ],)

    ),
    ),
    );
  }
}
