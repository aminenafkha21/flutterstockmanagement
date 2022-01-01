import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_family.dart';

class DetailPage extends StatelessWidget {
  final ModelFamily family;
  DetailPage({this.family});

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
        title: Text('Detail Category'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${family.familyName} "),
          ],
        ),
      ),
    );
  }
}
