import 'package:aniuaze/models/user_model.dart';
import 'package:aniuaze/screens/home_screen.dart';
import 'package:aniuaze/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Entrar'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 15),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            )
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validaEmail,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: _validaPassword,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if(_emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text('Insira seu email no campo "E-mail" e clique em "Esqueci minha senha"'),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 4),
                              )
                          );
                        else {
                          model.recoverPass(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("Confira sem E-mail"),
                                backgroundColor: Theme
                                    .of(context)
                                    .primaryColor,
                                duration: Duration(seconds: 2),
                              )
                          );
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                        model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      },
                    ),
                  )
                ],
              ));
        }));
  }

  void _onSuccess(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao entrar!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

  String _validaEmail(String text) {
    if (text.isEmpty || !text.contains("@")) {
      return "E-mail inválido!";
    }
    return null;
  }

  String _validaPassword(String text) {
    if (text.isEmpty || text.length < 6) {
      return "Senha inválida!";
    }
    return null;
  }
}
