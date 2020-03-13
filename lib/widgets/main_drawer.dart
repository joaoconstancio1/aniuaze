import 'package:aniuaze/models/user_model.dart';
import 'package:aniuaze/screens/formScreen.dart';
import 'package:aniuaze/screens/home_screen.dart';
import 'package:aniuaze/screens/login_screen.dart';
import 'package:aniuaze/screens/myAnimals.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return Drawer(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        "Aniuaze",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    Text(
                      "${!model.isLoggedIn() ? "" : model.userData["name"]}",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    Text(
                      "${!model.isLoggedIn() ? "" : model.userData["email"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.list,
                  size: 25,
                ),
                title: Text("Todos os Animais", style: TextStyle(fontSize: 18)),
                onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));},
              ),
              ListTile(
                leading: Icon(
                  Icons.add,
                  size: 25,
                ),
                title: Text("Cadastrar Animal", style: TextStyle(fontSize: 18)),
                onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormScreen()));},
              ),
              ListTile(
                leading: Icon(
                  Icons.library_books,
                  size: 25,
                ),
                title: Text(
                  "Meus animais",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAnimals()));},
              ),
              ListTile(
                leading: Icon(
                  Icons.message,
                  size: 25,
                ),
                title: Text(
                  "Chat",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                //onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));},
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
                title: Text(
                  "Sair",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  model.signOut();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
