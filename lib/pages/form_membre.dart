import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_family.dart';
import 'package:stockmanagementflutter/model/model_membre.dart';
import 'package:stockmanagementflutter/utils/db_helper.dart';

class FormMembre extends StatefulWidget {
  final ModelMembre membre;

  FormMembre({this.membre});

  @override
  _FormMembreState createState() => _FormMembreState();
}

class _FormMembreState extends State<FormMembre> {
  DatabaseHelper db = DatabaseHelper();

  TextEditingController _NameController = TextEditingController();
  TextEditingController _SurnameController = TextEditingController();

  TextEditingController _Phone1Controller = TextEditingController();
  TextEditingController _Phone2Controller = TextEditingController();





  @override
  void initState() {
    super.initState();
    if (widget.membre != null) {
      _NameController =
          TextEditingController(text: widget.membre.name);
      _SurnameController =
          TextEditingController(text: widget.membre.surname);
      _Phone1Controller =
          TextEditingController(text: widget.membre.phoneone);
      _Phone2Controller =
          TextEditingController(text: widget.membre.phonetwo);

    }
  }

  Future<void> createOrUpdateMembre() async {
    if (widget.membre == null) {
      // create
      await db.saveMembre(ModelMembre(
        name: _NameController.text,
        surname: _SurnameController.text,
        phoneone: _Phone1Controller.text,
        phonetwo: _Phone2Controller.text,
      ));
      Navigator.pop(context, 'save');
    } else {
      // update
      await db.updateMembre(
        ModelMembre.fromMap({
          'id': widget.membre.id,
          'name': _NameController.text,
          'surname': _SurnameController.text,
          'phoneone': _Phone1Controller.text,
          'phonetwo': _Phone2Controller.text,


        }),
      );
      Navigator.pop(context, 'update');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.yellow], stops: [0.5, 1.0],
            ),
          ),
        ),
        centerTitle: true,
        title: Text('Edit Membre'),
      ),
      body:    Stack(

          children: <Widget>[
          Image.asset(
          'assets/images/background.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          ),
          SafeArea(
          child:
        ListView(
            padding: EdgeInsets.all(15),
            children: [
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _NameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      controller: _SurnameController,
                      decoration: InputDecoration(
                        labelText: 'Surname',
                      ),
                    ),
                    TextFormField(
                      controller: _Phone1Controller,
                      decoration: InputDecoration(
                        labelText: 'Phone 1 ',
                      ),
                    ),
                    TextFormField(
                      controller: _Phone2Controller,
                      decoration: InputDecoration(
                        labelText: 'Phone 2 ',
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () {
                        createOrUpdateMembre();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: widget.membre == null
                          ? Text('Create')
                          : Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
          ),
      ],
      ),
    );
  }
}
