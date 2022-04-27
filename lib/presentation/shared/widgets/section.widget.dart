import 'package:flutter/material.dart';

class SectionWithTitleWidget extends StatelessWidget {
  final Widget title;
  final Widget? postfix;
  final Widget child;

  const SectionWithTitleWidget({
    Key? key,
    required this.title,
    required this.child,
    this.postfix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: title),
              postfix ?? SizedBox.square(dimension: IconTheme.of(context).size ?? 24.0),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
