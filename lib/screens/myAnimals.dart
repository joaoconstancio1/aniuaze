import 'package:aniuaze/models/user_model.dart';
import 'package:aniuaze/tiles/animal_tile.dart';
import 'package:aniuaze/widgets/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MyAnimals extends StatefulWidget {
  @override
  _MyAnimalsState createState() => _MyAnimalsState();
}

class _MyAnimalsState extends State<MyAnimals> {
  /* DocumentSnapshot userData;
  @override
  void initState() {
    UserModel().getUser().then((map){
      userData = map;
      print(" Esté são os dados ${userData.documentID}");
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("animals").where('userId', isEqualTo: model.firebaseUser.uid).orderBy(
                  "name", descending: false).getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else {
                  return Scaffold(
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
    );
  }
}
