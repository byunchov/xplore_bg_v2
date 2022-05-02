import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderWidget extends StatefulWidget {
  final int initialPage;
  final double viewportFraction;
  final List<Widget> children;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration animationDuration;
  final bool showIndicator;
  final EdgeInsets padding;
  final void Function(int index)? onPageChanged;
  final PageController? controller;

  const CarouselSliderWidget({
    Key? key,
    required this.children,
    this.initialPage = 0,
    this.viewportFraction = 1,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 6),
    this.animationDuration = const Duration(milliseconds: 1100),
    this.showIndicator = false,
    this.padding = const EdgeInsets.all(12),
    this.onPageChanged,
    this.controller,
  }) : super(key: key);

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  late final PageController pageController;
  int currentPage = 0;

  Timer? _carosuelTmer;

  Timer getTimer() {
    return Timer.periodic(widget.autoPlayInterval, (timer) {
      int index = currentPage;
      if (index == widget.children.length) {
        index = 0;
      } else {
        index++;
      }
      animateToPage(index);
    });
  }

  void animateToPage(int index) {
    pageController.animateToPage(
      index,
      duration: widget.animationDuration,
      curve: Curves.easeInOutCirc,
    );
    setState(() {
      currentPage = index;
    });
  }

  @override
  void initState() {
    pageController = widget.controller ??
        PageController(initialPage: widget.initialPage, viewportFraction: widget.viewportFraction);
    if (widget.autoPlay) _carosuelTmer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              if (index != currentPage) {
                setState(() {
                  currentPage = index;
                });
              }
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (_, index) {
              return AnimatedBuilder(
                animation: pageController,
                builder: (ctx, child) {
                  return child!;
                },
                child: Padding(
                  padding: widget.padding,
                  child: GestureDetector(
                    onPanDown: (d) {
                      if (widget.autoPlay) {
                        _carosuelTmer?.cancel();
                        _carosuelTmer = null;
                      }
                    },
                    onPanCancel: () {
                      if (widget.autoPlay) _carosuelTmer = getTimer();
                    },
                    child: widget.children[index],
                  ),
                ),
              );
            },
            itemCount: widget.children.length,
          ),
        ),
        if (widget.showIndicator) ...[
          const SizedBox(height: 12),
          AnimatedSmoothIndicator(
            activeIndex: currentPage,
            count: widget.children.length,
            effect: WormEffect(
              type: WormType.thin,
              dotWidth: 12,
              dotHeight: 12,
              activeDotColor: Colors.cyan[500]!,
            ),
            // duration: widget.animationDuration,
            onDotClicked: (index) {
              // _carosuelTmer?.cancel();
              // animateToPage(index);
              // _carosuelTmer = getTimer();
            },
          ),
        ]
      ],
    );
  }
}
