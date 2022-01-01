import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_component.dart';

class DetailComponentPage extends StatelessWidget {
  final ModelComponent component;
  DetailComponentPage({this.component});

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
            Text(" Component Name : ${component.namecom} "),
            Text("Date : ${component.dateaq} "),
            Text("Quantity Stock : ${component.qtestock} "),
            Text("Category :${component.category} "),
          ],
        ),
      ),
    );
  }
}
