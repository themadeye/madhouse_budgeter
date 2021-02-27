
import 'package:flutter/material.dart';

import 'package:madhouse_budgeter/constants.dart';
import 'package:madhouse_budgeter/model/transaction.dart';

class HomeScreen extends StatefulWidget{

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  List<Transaction> transactions = [
    Transaction(type: 'Income', category: 'Salary', detail: 'Monthly Salaray', amount: '6000', date: '2020-06-26', icon:'salary.png'),
    Transaction(type: 'Expenses', category: 'Food', detail: 'Had Bugger King',amount: '350', date: '2020-06-26', icon:'food.png'),
    Transaction(type: 'Expenses', category: 'Entertainment', detail: 'Avengers: End Game', amount: '150', date: '2020-06-27', icon:'entertainment.png'),
    Transaction(type: 'Expenses', category: 'Shopping', detail: 'Bought PS4 games', amount: '400', date: '2020-06-27', icon:'shopping.png'),
    Transaction(type: 'Expenses', category: 'Life Spend', detail: 'Bill', amount: '600', date: '2020-06-27', icon:'payment.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MadhouseBudgeterTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            getExpenseDetailUI(),
            getExpenseList()
          ],
        ),
      ),
    );
  }

  Widget getExpenseList(){
    double height = MediaQuery.of(context).size.height;
    print(height);
    return Container(
      height: 480.0,
      child: Scaffold(
        body: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                onTap: (){},
                title: Text('${transactions[index].detail} - ${transactions[index].amount}'),
                subtitle: Text('${transactions[index].date}'),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${transactions[index].icon}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getExpenseDetailUI(){
    return Column(
      children: <Widget>[
//        SizedBox(height: 80),
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16 - 8.0 * 0.0,
                  bottom: 12 - 8.0 * 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.grey.withOpacity(0.2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              onTap: (){},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'In Come',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '6000',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 1,
                        height: 42,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.grey.withOpacity(0.2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Expenses',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '2500',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getAppBarUI(){
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16 - 8.0 * 0.0,
                  bottom: 12 - 8.0 * 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(32.0)),
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: MadhouseBudgeterTheme.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.calendar_today,
                              color: MadhouseBudgeterTheme.grey,
                              size: 18,
                            ),
                          ),
                          Text(
                            '15 May',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: MadhouseBudgeterTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              letterSpacing: -0.2,
                              color: MadhouseBudgeterTheme.darkerText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(32.0)),
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: MadhouseBudgeterTheme.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}