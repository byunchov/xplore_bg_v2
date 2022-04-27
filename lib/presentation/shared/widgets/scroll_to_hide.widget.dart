import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final Duration duration;
  final double maxHeight;

  const ScrollToHideWidget({
    Key? key,
    required this.controller,
    required this.child,
    this.duration = kThemeAnimationDuration,
    this.maxHeight = 66,
  }) : super(key: key);

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool _isVisible = true;

  @override
  void initState() {
    widget.controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    final direction = widget.controller.position.userScrollDirection;
    switch (direction) {
      case ScrollDirection.forward:
        showWidget();
        break;
      case ScrollDirection.reverse:
        hideWidget();
        break;
      case ScrollDirection.idle:
        break;
    }
  }

  void showWidget() {
    if (!_isVisible) setState(() => _isVisible = true);
  }

  void hideWidget() {
    if (_isVisible) setState(() => _isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      duration: widget.duration,
      height: _isVisible ? widget.maxHeight : 0,
      child: Wrap(children: [widget.child]),
      alignment: Alignment.center,
    );
  }
}
