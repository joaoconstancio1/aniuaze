import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnimalScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  AnimalScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(snapshot.data['name']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              width: 500,
              child: AspectRatio(
                aspectRatio: 0.9,
                child: Carousel(
                  images: snapshot.data["images"].map((url) {
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotBgColor: Colors.transparent,
                  autoplay: false,
                ),
              ),
            ),
            _buildText('Nome:  ', '${snapshot.data['name']}'),
            _buildText('Porte:  ', '${snapshot.data['porte']}'),
            _buildText('Descrição:  ', '${snapshot.data['description']}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.message,
            size: 25,
          ),
          onPressed: () {}),
    );
  }
}

Container _buildText(text, snapshot) {
  return Container(
      child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        Expanded(
          child: Text(
            snapshot,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  ));
}

TextStyle _textStyle() {
  return TextStyle(fontSize: 16);
}
