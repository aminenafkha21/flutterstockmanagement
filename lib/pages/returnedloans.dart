import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockmanagementflutter/model/model_returnedloan.dart';
import 'package:stockmanagementflutter/pages/categories.dart';
import 'package:stockmanagementflutter/pages/detail_returnedloan.dart';
import 'package:stockmanagementflutter/pages/form_returnedloans.dart';
import 'package:stockmanagementflutter/pages/login_page.dart';
import 'package:stockmanagementflutter/pages/membres.dart';
import 'package:stockmanagementflutter/utils/db_helper.dart';

class ReturnedLoansPage extends StatefulWidget {
  @override
  _ReturnedLoansPageState createState() => _ReturnedLoansPageState();
}

class _ReturnedLoansPageState extends State<ReturnedLoansPage> {
  String email = '';
  String username = '';
  List<ModelReturnedLoan> listRetrunedLoans = [];
  var _loans = List<String>();



  DatabaseHelper db = DatabaseHelper();

  Future<void> _getAllRetrunedLoans() async {
    var list = await db.getAllLoans();
    setState(() {
      listRetrunedLoans.clear();
      list.forEach((element) {
        listRetrunedLoans.add(ModelReturnedLoan.fromMap(element));

      });
      print(list);
    });

  }










  _loadLoans(int id) async {
    String loans = await db.getLoan(id);
    print(loans);
    return loans;
  }





  Future<void> _deleteReturnedLoan(ModelReturnedLoan loan, int position) async {
    await db.deleteReturnedLoan(loan.id);

    setState(() {
      listRetrunedLoans.removeAt(position);
    });
  }


  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormReturnedLoan(),
      ),
    );

    if (result == 'save') {
      await _getAllRetrunedLoans();
    }
  }

  Future<void> _openFormEdit(ModelReturnedLoan returnedLoan ) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormReturnedLoan(returnedLoan: returnedLoan),
      ),
    );

    if (result == 'update') {
      await _getAllRetrunedLoans();
    }
  }

  Future<void> _openroute(String ch) async {


    if (ch == 'Membres') {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MembresPage(),
        ),
      );
    }
    else     if (ch == 'Categories') {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoriesPage(),
        ),
      );


    }

  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void getDataPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      username = pref.getString('username');
      email = pref.getString('email');
    });
  }


  @override
  void initState() {
    super.initState();
    _getAllRetrunedLoans();
    getDataPref();

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
        title: Text('Returned Loans Details'),
        elevation: 0,
      ),
      drawer:  Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage("assets/images/avater.jpg"),

                  ),
                  Text("Administrator"),
                  Text("$username"),

                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.yellow], stops: [0.5, 1.0],
                ),

              ),
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.black,),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.category,color: Colors.black,),
              title: Text('Categories'),
              onTap: () {
                _openroute("Categories");
              },
            ),
            ListTile(
              leading: Icon(Icons.family_restroom,color: Colors.black,),
              title: Text('Membres'),
              onTap: () {
                _openroute("Membres");
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,color: Colors.black,),
              title: Text('LOGOUT'),
              onTap: logout,
            ),

            Divider()
          ],
        ),
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
            child: ListView.builder(
              itemCount: listRetrunedLoans.length,
              itemBuilder: (context, index) {
                ModelReturnedLoan returnedLoan = listRetrunedLoans[index];



                return Column(
                  children: [
                    Container(
                      margin:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(3, 4))
                        ],
                      ),
                      child :ListTile(
                        leading: Image.asset(
                          'assets/images/background.jpg',
                          fit: BoxFit.cover,
                          width: 90,
                          height: 100,
                        ),
                        title: Text(
                          "#${returnedLoan.id}",
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Etat : ${returnedLoan.etat} "),
                            SizedBox(height: 10),
                            Container(
                              height: 40,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                      left: 20,
                                      bottom: 0,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Image.network(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRxHTyqjCdnZsEM-EkMvn3FDBkDADcaEZ3GN1YEdWFToAJm83nX&usqp=CAU'))),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: CircleAvatar(child: IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {
                                        // DETAIL PAGE
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailReturnedLoanPage(
                                              returnedLoan: returnedLoan,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                      ,backgroundColor: Colors.cyan,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        trailing: Wrap(
                            children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.yellow,
                                  ),
                                  onPressed: () {
                                    // OPEN FORM EDIT
                                    _openFormEdit(returnedLoan);
                                  },
                                ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  AlertDialog hapus = AlertDialog(
                                    title: Text('Informations'),
                                    content: Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            "You want to delete this loan  ?",
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text('Yes'),
                                        onPressed: () {
                                          // DELETE
                                          _deleteReturnedLoan(returnedLoan, index);
                                          Navigator.pop(context);
                                        },
                                      ),

                                      FlatButton(
                                        child: Text('No'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],

                                  );
                                  showDialog(builder: (context) => hapus, context: context);

                                },


                              ),
                            ]
                        ),


                      ),
                    ),
                    Divider(thickness: 2)
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.cyan,
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }
}
