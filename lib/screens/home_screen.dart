import 'package:aniuaze/tiles/animal_tile.dart';
import 'package:aniuaze/widgets/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  String successMsg = '';

  HomeScreen({this.successMsg});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("animals")
            .orderBy("date", descending: true)
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text("Aniuaze"),
                centerTitle: true,
              ),
              drawer: MainDrawer(),
              body: ListView(
                children: snapshot.data.documents.map((doc) {
                  return AnimalTile(doc);
                }).toList(),
              ),
            );
          }
        });
  }

  void showSnackBar() {
    if (widget.successMsg != null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          widget.successMsg,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }
  }
}
