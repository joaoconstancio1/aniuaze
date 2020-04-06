import 'package:aniuaze/screens/animal_screen.dart';
import 'package:aniuaze/screens/formScreen.dart';
import 'package:aniuaze/screens/home_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAnimalTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final String animalId;

  MyAnimalTile({this.snapshot, this.animalId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormScreen(animal: snapshot)));
                },
                child: new Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20.0,
                ),
                shape: new CircleBorder(),
                color: Theme.of(context).primaryColor,
              ),
              FlatButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Deseja realmente deletar?"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancelar")),
                            FlatButton(
                                onPressed: () {
                                  snapshot.reference.delete();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => HomeScreen()));
                                },
                                child: Text("Sim")),
                          ],
                        );
                      });
                },
                child: new Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 20.0,
                ),
                shape: new CircleBorder(),
                color: Colors.red,
              )
            ],
          ),
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  snapshot.data["name"],
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AnimalScreen(snapshot)));
                  },
                  child: Text(
                    "Visualizar",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
