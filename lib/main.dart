import 'package:aniuaze/models/user_model.dart';
import 'package:aniuaze/screens/formScreen.dart';
import 'package:aniuaze/screens/home_screen.dart';
import 'package:aniuaze/screens/login_screen.dart';
import 'package:aniuaze/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'Aniuaze',
        theme: ThemeData(
            primaryColor: Colors.green
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}