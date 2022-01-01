import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_component.dart';
import 'package:stockmanagementflutter/model/model_family.dart';
import 'package:stockmanagementflutter/utils/db_helper.dart';
import 'package:intl/intl.dart';


class FormComponent extends StatefulWidget {
  final ModelComponent component;

  FormComponent({this.component});

  @override
  _FormComponentState createState() => _FormComponentState();
}

class _FormComponentState extends State<FormComponent> {


  DatabaseHelper db = DatabaseHelper();



  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  TextEditingController _NameController = TextEditingController();
  TextEditingController _QteController = TextEditingController();
  TextEditingController _DateController = TextEditingController();
  var _selectedValue;
  var vf;

  var _categories = List<DropdownMenuItem>();




  @override
  void initState() {
    super.initState();
    if (widget.component != null) {
      _NameController =
          TextEditingController(text: widget.component.namecom);
      _QteController =
          TextEditingController(text: widget.component.qtestock.toString() );
      _DateController =
          TextEditingController(text: widget.component.dateaq);

    }
    _loadCategories();

  }



  _loadCategories() async {
    var categories = await db.getAllFamily();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['familyName']),
          value:  category['categoryid'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _DateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }


  Future<void> createOrUpdateComponent() async {
    if (widget.component == null) {
      // create
      await db.saveComponent(ModelComponent(
        namecom: _NameController.text,
        qtestock: int.parse(_QteController.text),
        dateaq: _DateController.text,
        category:_selectedValue,

      ));
      Navigator.pop(context, 'save');
    } else {
      // update
      await db.updateComponent(
        ModelComponent.fromMap({
          'id': widget.component.id,
          'namecom': _NameController.text,
          'qtestock':int.parse(_QteController.text),
          'dateaq': _DateController.text,
          'category':_selectedValue,
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
        title: Text('Edit Component'),
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
                      controller: _NameController,
                      decoration: InputDecoration(
                        labelText: 'Component Name',
                      ),
                    ),
                    TextFormField(
                      controller: _QteController ,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'QTE',
                      ),
                    ),
                    TextField(
                      controller: _DateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: 'Pick a Date',
                        prefixIcon: InkWell(
                          onTap: () {
                            _selectedTodoDate(context);
                          },
                          child: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),

                    DropdownButtonFormField(
                      value: _selectedValue,
                      items: _categories,
                      hint: Text('Category'),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                    /**
                    FutureBuilder<List<ModelFamily>>(
                      future: db.getAllFamily(),
                      builder: (context, snapshot) {
                        return snapshot.hasData ? CategoriesDropDown(snapshot.data, callback) : Text('No categories');
                      },
                    ),**/

                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () {
                        createOrUpdateComponent();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: widget.component == null
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
