import 'package:aniuaze/blocs/animal_bloc.dart';
import 'package:aniuaze/screens/home_screen.dart';

import 'package:aniuaze/widgets/images_widget.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final AnimalBloc _animalBloc;

  _FormScreenState() : _animalBloc = AnimalBloc();

  List<Porte> _portes = Porte.getCompanies();
  List<DropdownMenuItem<Porte>> _dropdownMenuItems;
  Porte _selectedPorte;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_portes);
    _selectedPorte = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Porte>> buildDropdownMenuItems(List portes) {
    List<DropdownMenuItem<Porte>> items = List();
    for (Porte porte in portes) {
      items.add(
        DropdownMenuItem(
          value: porte,
          child: Text(porte.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Porte selectedPorte) {
    setState(() {
      _selectedPorte = selectedPorte;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cadastrar Animal'),
        centerTitle: true,
        actions: <Widget>[
          StreamBuilder<bool>(
              stream: _animalBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      snapshot.data ? null : saveAnimal();
                    });
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Form(
              key: _formKey,
              child: StreamBuilder<Map>(
                  stream: _animalBloc.outData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return ListView(
                      padding: EdgeInsets.all(16),
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Imagens",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                            Text(
                              " (Segure a imagem para deletar)",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 10),
                            ),
                          ],
                        ),
                        ImagesWidget(
                          context: context,
                          initialValue: snapshot.data["images"],
                          onSaved: _animalBloc.saveImages,
                          validator: _validateImages,
                        ),
                        TextFormField(
                          initialValue: snapshot.data["nome"],
                          style: _fieldStyle,
                          decoration: _buildDecoration("Nome"),
                          onSaved: _animalBloc.saveNome,
                          validator: _validateName,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text("Selecione o Porte"),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButton(
                          value: _selectedPorte,
                          items: _dropdownMenuItems,
                          onChanged: onChangeDropdownItem,
                        ),
                        TextFormField(
                          maxLines: 3,
                          initialValue: snapshot.data["description"],
                          style: _fieldStyle,
                          decoration: _buildDecoration("Descrição"),
                          onSaved: _animalBloc.saveDescription,
                        ),
                      ],
                    );
                  })),
          StreamBuilder<bool>(
              stream: _animalBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IgnorePointer(
                  ignoring: !snapshot.data,
                  child: Container(
                    color: snapshot.data ? Colors.black54 : Colors.transparent,
                  ),
                );
              })
        ],
      ),
    );
  }

  String _validateImages(List images) {
    if (images.isEmpty) return "Adicione imagens do Animal";
    return null;
  }

  String _validateName(String text) {
    if (text.isEmpty) return "Informe o Nome do Animal";
    return null;
  }

  void saveAnimal() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _animalBloc.savePorte(_selectedPorte.name);

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Cadastrando Animal...",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(minutes: 1),
        backgroundColor: Theme.of(context).primaryColor,
      ));

      bool success = await _animalBloc.saveAnimal();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      if(success == true)
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(
              successMsg: "Animal Cadastrado!",
            )));
      else{
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
           "Erro ao salvar!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ));
      }
    }
  }

  InputDecoration _buildDecoration(String label) {
    return InputDecoration(
        labelText: label, labelStyle: TextStyle(color: Colors.black54));
  }

  final _fieldStyle = TextStyle(color: Colors.black, fontSize: 16);
}

class Porte {
  int id;
  String name;

  Porte(this.id, this.name);

  static List<Porte> getCompanies() {
    return <Porte>[
      Porte(1, 'Pequeno'),
      Porte(2, 'Médio'),
      Porte(3, 'Grande'),
    ];
  }
}
