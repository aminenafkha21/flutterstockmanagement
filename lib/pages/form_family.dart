import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_family.dart';
import 'package:stockmanagementflutter/utils/db_helper.dart';

class FormFamily extends StatefulWidget {
  final ModelFamily family;

  FormFamily({this.family});

  @override
  _FormFamilyState createState() => _FormFamilyState();
}

class _FormFamilyState extends State<FormFamily> {
  DatabaseHelper db = DatabaseHelper();

  TextEditingController _firstNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.family != null) {
      _firstNameController =
          TextEditingController(text: widget.family.familyName);

    }

  }

  Future<void> createOrUpdateFamily() async {
    if (widget.family == null) {
      // create
      await db.saveFamily(ModelFamily(
        familyName: _firstNameController.text,
      ));
      Navigator.pop(context, 'save');
    } else {
      // update
      await db.updateFamily(
        ModelFamily.fromMap({
          'categoryid': widget.family.categoryid,
          'familyName': _firstNameController.text,

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
        title: Text('Edit Category'),
      ),
      body:
        Stack(

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
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Category Name',
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () {
                        createOrUpdateFamily();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: widget.family == null
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
