import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_returnedloan.dart';
import 'package:stockmanagementflutter/utils/db_helper.dart';
import 'package:intl/intl.dart';


class FormReturnedLoan extends StatefulWidget {
  final ModelReturnedLoan returnedLoan;

  FormReturnedLoan({this.returnedLoan});

  @override
  _FormReturnedLoanState createState() => _FormReturnedLoanState();
}

class _FormReturnedLoanState extends State<FormReturnedLoan> {


  DatabaseHelper db = DatabaseHelper();



  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  TextEditingController _EtatController = TextEditingController();
  TextEditingController _DateController = TextEditingController();
  var _selectedValue;
  var vf;

  var _loans = List<DropdownMenuItem>();




  @override
  void initState() {
    super.initState();
    if (widget.returnedLoan != null) {

      _EtatController =
          TextEditingController(text: widget.returnedLoan.etat.toString() );
      _DateController =
          TextEditingController(text: widget.returnedLoan.dateretour);

    }
    _loadLoans();

  }



  _loadLoans() async {
    var loans = await db.getAllLoans();
    loans.forEach((loan) {
      setState(() {
        _loans.add(DropdownMenuItem(
          child: Text(loan['id']),
          value:  loan['id'],
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


  Future<void> createOrUpdateReturnedLoan() async {
    if (widget.returnedLoan == null) {
      // create
      await db.saveReturnedLoan(ModelReturnedLoan(
        etat: _EtatController.text,
        dateretour: _DateController.text,
        loan:_selectedValue,

      ));
      Navigator.pop(context, 'save');
    } else {
      // update
      await db.updateReturnedLoan(
        ModelReturnedLoan.fromMap({
          'id': widget.returnedLoan.id,
          'etat': _EtatController.text,
          'dateretour': _DateController.text,
          'loan':_selectedValue,
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
        title: Text('Edit ReturnedLoan'),
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
                            controller: _EtatController,
                            decoration: InputDecoration(
                              labelText: 'Etat ',
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
                            items: _loans,
                            hint: Text('Loan'),
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
                              createOrUpdateReturnedLoan();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: widget.returnedLoan == null
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
