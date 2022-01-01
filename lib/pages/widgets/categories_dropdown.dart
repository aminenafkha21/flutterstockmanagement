import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanagementflutter/model/model_family.dart';

class CategoriesDropDown extends StatefulWidget {
  List<ModelFamily> categories;

  Function(ModelFamily) callback;

  CategoriesDropDown(
      this.categories,
      this.callback, {
        Key key,
      }) : super(key: key);

  @override
  _CategoriesDropDownState createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<ModelFamily>(
      hint: Text('Select category'),
      onChanged: (ModelFamily value){
        setState(() {
          widget.callback(value);
        });
      },
      items: widget.categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.familyName),

        );
      }).toList()
    );
  }
}
