import 'package:aniuaze/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  String successMsg;
  HomeScreen({this.successMsg});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
    appBar: AppBar(
      title: Text("Aniuaze"),
      centerTitle: true,
    ),
      drawer: MainDrawer(),
      body: ListView(

        children: <Widget>[
          Container(
            child: Text('AHHHHHHHHH'),
          ),
        ],
      ),
    );
  }
  void showSnackBar(){
    if(widget.successMsg.length> 0){
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



