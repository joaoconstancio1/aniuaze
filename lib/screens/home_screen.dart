import 'package:aniuaze/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Aniuaze"),
      centerTitle: true,
    ),
      drawer: MainDrawer(),
      body: ListView(
        children: <Widget>[
          Container(
            child: Text("AAAAAAAAAAHHHHHHHHHH"),
          )
        ],
      ),
    );
  }
}
