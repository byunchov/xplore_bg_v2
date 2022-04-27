import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScrollbarWrapperWidget extends HookWidget {
  final ScrollableWidgetBuilder builder;

  const ScrollbarWrapperWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = useScrollController();
    return ScrollbarTheme(
      data: Theme.of(context).scrollbarTheme,
      child: Scrollbar(
        // trackVisibility: true,
        // showTrackOnHover: true,
        interactive: true,
        radius: const Radius.circular(15),
        controller: controller,
        child: builder(context, controller),
      ),
    );
  }
}
