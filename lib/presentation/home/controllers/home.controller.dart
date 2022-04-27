import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nabvarPageControllerProvider = StateNotifierProvider<PageChangedNotifier, int>((ref) {
  ref.onDispose(() => ref.notifier.onDispose());
  return PageChangedNotifier();
});

class PageChangedNotifier extends StateNotifier<int> {
  final _pageController = PageController();
  PageChangedNotifier() : super(0);

  int get currentIndex => state;

  PageController get pageController => _pageController;

  void animateTo(int index) {
    _pageController.animateToPage(
      index,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
    );
    state = index;
  }

  void jumpTo(int index) {
    _pageController.jumpToPage(
      index,
    );
    state = index;
  }

  void onDispose() {
    pageController.dispose();
  }
}
