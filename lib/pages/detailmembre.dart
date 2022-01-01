import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_membre.dart';

class DetailMembrePage extends StatelessWidget {
  final ModelMembre membre;
  DetailMembrePage({this.membre});

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
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name : ${membre.name} "),
            Text("Surname : ${membre.surname} "),
            Text("N° Phone 1 : ${membre.phoneone} "),
            Text("N° Phone 2 : ${membre.phonetwo} "),

          ],
        ),
      ),
    );
  }
}
