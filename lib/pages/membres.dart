import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockmanagementflutter/model/model_membre.dart';
import 'package:stockmanagementflutter/pages/categories.dart';
import 'package:stockmanagementflutter/pages/components.dart';
import 'package:stockmanagementflutter/pages/detailmembre.dart';
import 'package:stockmanagementflutter/pages/form_component.dart';
import 'package:stockmanagementflutter/pages/form_membre.dart';
import 'package:stockmanagementflutter/pages/loans.dart';
import 'package:stockmanagementflutter/pages/login_page.dart';
import 'package:stockmanagementflutter/pages/returnedloans.dart';
import 'package:stockmanagementflutter/utils/db_helper.dart';

class MembresPage extends StatefulWidget {
  @override
  _MembresPageState createState() => _MembresPageState();
}

class _MembresPageState extends State<MembresPage> {
  String email = '';
  String username = '';
  List<ModelMembre> listMembres = [];
  var _categories = List<String>();


  DatabaseHelper db = DatabaseHelper();

  Future<void> _getAllMembres() async {
    var list = await db.getAllMembres();
    setState(() {
      listMembres.clear();
      list.forEach((element) {
        listMembres.add(ModelMembre.fromMap(element));

      });
      print(list);
    });
  }











  Future<void> _deleteMembre(ModelMembre membre, int position) async {
    await db.deleteMembre(membre.id);

    setState(() {
      listMembres.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormMembre(),
      ),
    );

    if (result == 'save') {
      await _getAllMembres();
    }
  }

  Future<void> _openFormEdit(ModelMembre membre) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormMembre(membre: membre),
      ),
    );

    if (result == 'update') {
      await _getAllMembres();
    }
  }

  Future<void> _openroute(String ch) async {


    if (ch == 'Categories') {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoriesPage(),
        ),
      );
    }
    else     if (ch == 'Components') {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ComponentsPage() ,
        ),
      );


    } else     if (ch == 'Loans') {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoansPage(),
        ),
      );


    }else     if (ch == 'Rloans') {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReturnedLoansPage() ,
        ),
      );


    }
    else     if (ch == 'Unloans') {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoansPage(),
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
    _getAllMembres();
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
        title: Text('Membres'),
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
                  Text("amine"),
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
              leading: Icon(Icons.settings_input_component,color: Colors.black,),
              title: Text('Components'),
              onTap: () {
                _openroute("Components");
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
              leading: Icon(Icons.sticky_note_2_rounded,color: Colors.black,),
              title: Text('Loans'),
              onTap: () {
                _openroute("Loans");
              },
            ),
            ListTile(
              leading: Icon(Icons.sticky_note_2_sharp,color: Colors.black,),
              title: Text('Returned Loans'),
              onTap: () {
                _openroute("Rloans");
              },
            ),
            ListTile(
              leading: Icon(Icons.sticky_note_2_rounded,color: Colors.black,),
              title: Text('Unreturned Loans'),
              onTap: () {
                _openroute("Unloans");
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
          itemCount: listMembres.length,
          itemBuilder: (context, index) {
            ModelMembre membre = listMembres[index];



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
                    "${membre.name}",
                    style: TextStyle(fontSize: 25),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Quantity : ${membre.surname} "),
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
                                      builder: (context) => DetailMembrePage(
                                        membre: membre,
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
                            _openFormEdit(membre);
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
                                      "You want to delete this membre  ?",
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                FlatButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    // DELETE
                                    _deleteMembre(membre, index);
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
