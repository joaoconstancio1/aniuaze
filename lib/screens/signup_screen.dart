import 'package:aniuaze/models/user_model.dart';
import 'package:aniuaze/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Criar Conta'),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Nome Completo"),
                      validator: (text) {
                        if (text.isEmpty) return "Nome inválido";
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
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
                      controller: _addressController,
                      decoration: InputDecoration(hintText: "Endreço"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty) return "Endereço inválido";
                      },
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
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        child: Text(
                          "Registrar",
                          style: TextStyle(fontSize: 18),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "address": _addressController.text
                            };
                            model.signUp(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                      ),
                    )
                  ],
                ));
          },
        ));
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Usuário criado com sucesso!"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 1)).then((_){
      {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário!"),
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
