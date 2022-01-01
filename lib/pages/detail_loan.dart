import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_component.dart';
import 'package:stockmanagementflutter/model/model_loan.dart';

class DetailLoanPage extends StatelessWidget {
  final ModelLoan loan;
  DetailLoanPage({this.loan});

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
            Text(" Loan by  : ${loan.membre} "),
            Text("Loan Component : ${loan.component} "),
            Text("Quantity Stock : ${loan.qtestockloans} "),
          ],
        ),
      ),
    );
  }
}
