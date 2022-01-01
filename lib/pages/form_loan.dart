import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stockmanagementflutter/model/model_loan.dart';
import 'package:stockmanagementflutter/utils/db_helper.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';


class FormLoan extends StatefulWidget {
  final ModelLoan loan;

  FormLoan({this.loan});

  @override
  _FormLoanState createState() => _FormLoanState();
}

class _FormLoanState extends State<FormLoan> {


  DatabaseHelper db = DatabaseHelper();



  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  TextEditingController _QteController = TextEditingController();
  var _selectedValueM;
  var vf;
  var _selectedValueC;
  var Qte;



  var _membres = List<DropdownMenuItem>();
  var _components = List<DropdownMenuItem>();





  @override
  void initState() {
    super.initState();
    if (widget.loan != null) {

      _QteController =
          TextEditingController(text: widget.loan.qtestockloans.toString() );
      _selectedValueC=widget.loan.component;
      _selectedValueM=widget.loan.membre;



    }
    _loadMembres();
    _loadComponents();

  }



  _loadMembres() async {
    var membres = await db.getAllMembres();
    membres.forEach((membre) {
      setState(() {
        _membres.add(DropdownMenuItem(
          child: Text(membre['name']),
          value:  membre['id'],
        ));
      });
    });
  }

  _loadComponents() async {
    var components = await db.getAllComponents();
    components.forEach((component) {
      setState(() {
        _components.add(DropdownMenuItem(
          child: Text(component['namecom']),
          value:  component['id'],
        ));
      });
    });
  }



  Future<void> createOrUpdateLoan() async {
    ModelLoan model = ModelLoan(
      qtestockloans: int.parse(_QteController.text),
      membre: _selectedValueM,
      component: _selectedValueC,

    );
    if(_selectedValueM == null){
      Fluttertoast.showToast(
          msg: "Choose a membre!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 24);

    }
    else if(_selectedValueC== null){
      Fluttertoast.showToast(
          msg: "Choose a component!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 24);

    }
    else if(int.parse(_QteController.text)<1){
      Fluttertoast.showToast(
          msg: "Choose a valid QTE   !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 24);

    }
    else if(await db.checkloan(model) == 0 ) {
      Fluttertoast.showToast(
          msg: "This quantity is not available  !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 24);

    }else {
      if (widget.loan == null) {
        // create
        await db.saveLoan(ModelLoan(
          qtestockloans: int.parse(_QteController.text),
          membre: _selectedValueM,
          component: _selectedValueC,

        ));
        Navigator.pop(context, 'save');

      } else {
        // update
        await db.updateLoan(
          ModelLoan.fromMap({
            'id': widget.loan.id,
            'qtestockloans': int.parse(_QteController.text),
            'membre': _selectedValueM,
            'component': _selectedValueC,

          }),
        );
        Navigator.pop(context, 'update');
      }
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
        title: widget.loan == null
            ? Text('New Loan')
            : Text('Edit Loan') ,
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
                            controller: _QteController ,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'QTE',
                            ),
                          ),

                          DropdownButtonFormField(
                            value: _selectedValueM,
                            items: _membres,
                            hint: Text('$_selectedValueM'),
                            onChanged: (value) {
                              setState(() {
                                _selectedValueM  = value;
                              });
                            },

                          ),
                          DropdownButtonFormField(
                            value: _selectedValueC,
                            items: _components,
                            hint: Text('$_selectedValueC'),
                            onChanged: (value) {
                              setState(() {
                                _selectedValueC = value;
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
                              createOrUpdateLoan();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: widget.loan == null
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
