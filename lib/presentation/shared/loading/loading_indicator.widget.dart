import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CusrotmLoadingIndicator extends StatelessWidget {
  const CusrotmLoadingIndicator({Key? key, this.dimension = 64}) : super(key: key);

  final double dimension;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: LoadingIndicator(
        colors: [Colors.cyan[700]!, Colors.cyan[400]!],
        strokeWidth: 8,
        indicatorType: Indicator.ballRotateChase,
      ),
    );
  }
}
