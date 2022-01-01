import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockmanagementflutter/model/model_family.dart';
import 'package:stockmanagementflutter/pages/categories.dart';
import 'package:stockmanagementflutter/pages/components.dart';
import 'package:stockmanagementflutter/pages/form_family.dart';
import 'package:stockmanagementflutter/pages/loans.dart';
import 'package:stockmanagementflutter/pages/login_page.dart';
import 'package:stockmanagementflutter/pages/membres.dart';
import 'package:stockmanagementflutter/pages/returnedloans.dart';
import 'package:stockmanagementflutter/utils/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email = '';
  String username = '';
  List<ModelFamily> listFamily = [];
  DatabaseHelper db = DatabaseHelper();

  Future<void> _getAllFamily() async {
    var list = await db.getAllFamily();
    return list;

  }

  Future<void> _deleteFamily(ModelFamily family, int position) async {
    await db.deleteFamily(family.categoryid);

    setState(() {
      listFamily.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormFamily(),
      ),
    );

    if (result == 'save') {
      await _getAllFamily();
    }
  }

  Future<void> _openFormEdit(ModelFamily family) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormFamily(family: family),
      ),
    );

    if (result == 'update') {
      await _getAllFamily();
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
    _getAllFamily();
    getDataPref();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(

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
              leading: Icon(Icons.exit_to_app),
              title: Text('LOGOUT'),
              onTap: logout,
            ),

            Divider()
          ],
        ),
      ),


      appBar: AppBar(

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.yellow], stops: [0.5, 1.0],
            ),
          ),
        ),
        centerTitle: true,
        title: Text('Stock Management'),
        elevation: 0,

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
          Container(

            child: new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            height: size.height * .3,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage("assets/images/avater.jpg"),

                  ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Welcome Back !',
                              style: TextStyle(
                                  fontFamily: "Montserrat Medium",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                            Text(
                              'Administrator',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat Regular"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoriesPage(),
                                ),
                              );

                            },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: <Widget>[

                                Image( image: AssetImage('assets/images/category.png'),
                                  height: 128,

                                ),



                              Text(
                                'Categories',
                                style: cardTextStyle,
                              )


                            ],
                          ),
                        ),
                        ),

                        Card(

                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,

                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComponentsPage(),
                                ),
                              );

                            },

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image( image: AssetImage('assets/images/compnent.png'),
                                height: 128,

                              ),
                              Text(
                                'Components',
                                style: cardTextStyle,
                              )
                            ],
                          ),


                        ),
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MembresPage(),
                                ),
                              );

                            },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image( image: AssetImage('assets/images/membres.png'),
                                height: 128,

                              ),
                              Text(
                                'Membres',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoansPage(),
                                ),
                              );

                            },

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image( image: AssetImage('assets/images/loan.png'),
                                height: 128,

                              ),
                              Text(
                                'Loans',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReturnedLoansPage(),
                                ),
                              );

                            },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image( image: AssetImage('assets/images/loanr.png'),
                                height: 128,

                              ),
                              Text(
                                'Returned Loans',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                        ),
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image( image: AssetImage('assets/images/unloan.png'),
                                height: 128,

                              ),
                              Text(
                                'Unreturned Loans',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),






      );

  }
}
