import 'package:aniuaze/models/user_model.dart';
import 'package:aniuaze/screens/FormScreen.dart';
import 'package:aniuaze/screens/login_screen.dart';
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
                    /*Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 30, bottom: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://static-wp-canalr-prd.canalrural.com.br/2019/02/fcpzzb_abr_070120192595-640x427.jpg"),
                                fit: BoxFit.fill)),
                      ),*/
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
                  Icons.add,
                  size: 25,
                ),
                title: Text("Cadastrar Animal", style: TextStyle(fontSize: 18)),
                onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormScreen()));},
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  size: 25,
                ),
                title: Text(
                  "Configurações",
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
