import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_component.dart';
import 'package:stockmanagementflutter/model/model_returnedloan.dart';

class DetailReturnedLoanPage extends StatelessWidget {
  final ModelReturnedLoan returnedLoan;
  DetailReturnedLoanPage({this.returnedLoan});

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
            Text("Date : ${returnedLoan.dateretour} "),
            Text("Etat : ${returnedLoan.etat} "),
            Text(" Loan Ref :  #${returnedLoan.loan} "),
          ],
        ),
      ),
    );
  }
}
