import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:madhouse_budgeter/constants.dart';
import 'package:madhouse_budgeter/model/transaction.dart';
import 'package:madhouse_budgeter/model/category.dart';
import 'package:madhouse_budgeter/services/database.dart';

class ExpenseFormScreen extends StatefulWidget{

  @override
  State createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen>{
  final TextEditingController _memoInput = new TextEditingController();
  final TextEditingController _amountInput = new TextEditingController();
  final TextEditingController _dateInput = new TextEditingController();
  String _dropdownValue;
  String _dropdownName;
  List<Map> _myCategory = [{"icon":Icon(Icons.alarm),"name":"Alarm"},{"icon":Icon(Icons.ac_unit),"name":"AC Unit"}];
  List<Category> _categories = [
    Category('Food', Icons.food_bank_outlined),
    Category('Bills', Icons.payment_outlined),
    Category('Transportation', Icons.directions_bus),
    Category('Home', Icons.house),
    Category('Car', Icons.directions_car_outlined),
    Category('Entertainment', Icons.videogame_asset_outlined),
    Category('Shopping', Icons.shopping_bag_outlined),
    Category('Insurance', Icons.shield),
    Category('Tax', Icons.receipt_long_outlined),
    Category('Telephone', Icons.phone_outlined),
    Category('Cigarette', Icons.smoking_rooms_outlined),
    Category('Health', Icons.medical_services_outlined),
    Category('Sport', Icons.sports_football_outlined),
    Category('Baby', Icons.baby_changing_station_outlined),
    Category('Pet', Icons.pets_outlined),
    Category('Electronics', Icons.electrical_services_outlined),
    Category('Wine', Icons.wine_bar_outlined),
    Category('Snacks', Icons.cake_outlined),
    Category('Social', Icons.people),
    Category('Travel', Icons.airplanemode_active_outlined),
    Category('Eduation', Icons.menu_book_outlined),
    Category('Office', Icons.work_outline),
    Category('Other', Icons.menu_outlined),
  ];

  DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    _dateInput.text = _dateFormatter.format(DateTime.now());
    super.initState();
  }


  @override
  void dispose() {
    _memoInput.dispose();
    _amountInput.dispose();
    _dateInput.dispose();
    super.dispose();
  }

  Widget _buildBottomCupertinoPicker(Widget picker) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.darkBackgroundGray,
      child: GestureDetector(
        // Blocks taps from propagating to the modal sheet and popping.
        onTap: () {},
        child: SafeArea(
          top: false,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              brightness: Brightness.dark,
            ),
            child: picker,
          ),
        )),
    );
  }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    value: _dropdownValue,
                    onChanged: (value) {
                      setState(() {
                        _dropdownValue = value;
                      });
                    },
                    items: _categories.map((Category map) {
                      return new DropdownMenuItem(
                        value: map.name,
                        child: Row(
                          children: [
                            Icon(map.icon),
                            SizedBox(width: screenSize.width* 0.05),
                            Text(map.name)
                          ]
                        ),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    controller: _memoInput,
                    decoration: const InputDecoration(
                        labelText: "Memo",
                        hintText: "e.g Grab Food",
                        focusedBorder: MadhouseBudgeterTheme.BORDER
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _amountInput,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Amount",
                        hintText: "0",
                        focusedBorder: MadhouseBudgeterTheme.BORDER
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dateInput,
                    decoration: const InputDecoration(
                        labelText: "Date",
                        hintText: "Select date",
                        focusedBorder: MadhouseBudgeterTheme.BORDER),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                    onTap: () async {
                      if(Platform.isIOS){
                        showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildBottomCupertinoPicker(
                                CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  // set initialDateTime depending on add or modify mode
                                  initialDateTime: DateTime.now() ,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    setState(() {
                                      _dateInput.text =
                                          _dateFormatter.format(newDateTime);
                                    });
                                  },
                                ),
                              );
                            }
                        );
                      } else {
                        DateTime date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2100),
                        );
                        if(date != null){
                          setState(() {
                            _dateInput.text = _dateFormatter.format(date);
                          });
                        }
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height*0.05),
                        child:ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                              print("The Value : ${_dropdownValue}, ${_memoInput.text}, ${_amountInput.text}, ${_dateInput.text}");
                              await DatabaseService.db.insertTransaction(1 ,_dropdownValue, _memoInput.text, int.parse(_amountInput.text), _dateInput.text);
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Done.... !!!!!')));
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height*0.05),
                        child:ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                          },
                          child: Text('Cancel'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            padding: EdgeInsets.only(top: screenSize.height*0.05, left: screenSize.width*0.1, right: screenSize.width*0.1),
            margin: new EdgeInsets.symmetric(vertical: screenSize.height*0.2, horizontal: screenSize.width*0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: MadhouseBudgeterTheme.grey,
                  width: 5
              ),
            ),
            width: double.infinity,
            height: screenSize.height*0.5,
          ),
        ),
      )
    );
  }
}