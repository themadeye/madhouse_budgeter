import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:madhouse_budgeter/constants.dart';

class LoadingSpinner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Center(
        child: SpinKitChasingDots(
          color: MadhouseBudgeterTheme.darkerText,
          size: 50.0,
        ),
      ),
    );
  }
}