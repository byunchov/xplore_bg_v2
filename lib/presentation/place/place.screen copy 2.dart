import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets/section.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/places/details/activity_cards.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PlaceDetailsScreen extends StatefulWidget {
  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  final _scrollController = ScrollController();
  double appBarHeight = 150;

  final ab1 = const SliverAppBar(
    toolbarHeight: 140,
    automaticallyImplyLeading: false,
    title: Text("test title 1"),
  );
  final ab2 = const SliverAppBar(
    toolbarHeight: 70,
    pinned: true,
    title: Text("test title 2"),
  );
  late Widget appbar;

  @override
  void initState() {
    appbar = ab1;
    _scrollController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    _scrollController.dispose();
    super.dispose();
  }

  void listener() {
    final postion = _scrollController.position.pixels;
    if (postion >= 300) {
      setState(() {
        // appBarHeight = 80;
        appbar = ab2;
      });
    } else {
      setState(() {
        // appBarHeight = 140;
        appbar = ab1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          // const SliverPersistentHeader(
          //   pinned: true,
          //   delegate: CustomHeaderDelegate(expandedHeight: 300),
          // ),
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              color: Colors.green,
            ),
          ),
          // SliverAnimatedPaintExtent(duration: const Duration(milliseconds: 600), child: appbar),
          ScrollToSwapSliverWidgets(
            controller: _scrollController,
            child1: SliverToBoxAdapter(
              child: Container(
                height: 150,
                color: Colors.red,
              ),
            ),
            child2: const SliverAppBar(
              pinned: true,
              title: Text("test title 2"),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: _sectionTitle("Gallery", theme),
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(
                    width: 100,
                    color: Colors.green,
                  ),
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: _sectionTitle("Description", theme),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SelectableText(
                  "kdmi eidemkmdieufeokmfeiof",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: _sectionTitle("Activities", theme),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: _PlaceActivitiesBody(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: _sectionTitle("Nearby", theme),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      width: 100,
                      color: Colors.green,
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ScrollToHideWidget(
        controller: _scrollController,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Icon(Icons.heart_broken),
                Text("Likes"),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.bookmarks),
                Text("Bookmarks"),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.reviews_outlined),
                Text("Reviews"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _sectionTitle(String title, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
        const CustomDivider(
          width: 60,
          height: 3,
          margin: EdgeInsets.only(top: 10),
        ),
      ],
    );
  }
}

class ScrollToSwapSliverWidgets extends StatefulWidget {
  final ScrollController controller;
  final Widget child1;
  final Widget child2;
  final Duration duration;
  final double maxHeight;

  const ScrollToSwapSliverWidgets({
    Key? key,
    required this.controller,
    required this.child1,
    required this.child2,
    this.duration = const Duration(milliseconds: 600),
    this.maxHeight = 300,
  }) : super(key: key);

  @override
  State<ScrollToSwapSliverWidgets> createState() => _ScrollToSwapSliverWidgetsState();
}

class _ScrollToSwapSliverWidgetsState extends State<ScrollToSwapSliverWidgets> {
  bool _swapWidgets = true;
  late Widget _widget;

  @override
  void initState() {
    _widget = widget.child1;
    widget.controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    final position = widget.controller.position.pixels;
    final collapseExtent = widget.maxHeight + widget.maxHeight * 0.06;
    if (position <= collapseExtent) {
      forwardSwap();
    } else {
      reverseSwap();
    }
  }

  void forwardSwap() {
    if (!_swapWidgets) {
      setState(() {
        _swapWidgets = true;
        _widget = widget.child1;
      });
    }
  }

  void reverseSwap() {
    if (_swapWidgets) {
      setState(() {
        _swapWidgets = false;
        _widget = widget.child2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedPaintExtent(
      duration: widget.duration,
      child: _widget,
    );
  }
}

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
    this.maxHeight = kBottomNavigationBarHeight,
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
      duration: widget.duration,
      height: _isVisible ? widget.maxHeight : 0,
      child: Wrap(children: [widget.child]),
      alignment: Alignment.center,
    );
  }
}

class _PlaceActivitiesBody extends StatelessWidget {
  const _PlaceActivitiesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String maptTile = "https://maps.googleapis.com/maps/api/staticmap?center=41.83458,23.48632"
        "&zoom=14&size=600x200&scale=2&markers=color:red|41.83458,23.48632"
        "&language=bg&key=${AppConfig.mapsAPIKey}";

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PlaceActivitiyColorCard(
                  text: 'Restaurants',
                  color: Colors.orange[300]!,
                  icon: Icons.restaurant_menu,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: PlaceActivitiyColorCard(
                  text: 'Hotels',
                  color: Colors.blueAccent[400]!,
                  icon: Icons.hotel_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          PlaceActivityImageCard(
            text: "",
            icon: Icons.navigation_rounded,
            image: CustomCachedImage(
              imageUrl: maptTile,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  const CustomHeaderDelegate({
    Key? key,
    required this.expandedHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double imgHeight = (150 - shrinkOffset).clamp(0, 150);
    return Column(
      children: [
        SizedBox(
          height: imgHeight,
          child: const CustomCachedImage(imageUrl: "https://source.unsplash.com/random?mono+dark"),
        ),
        Expanded(child: _header(context, shrinkOffset)),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  Widget _header(BuildContext context, double shrinkOffset) {
    final theme = Theme.of(context);

    double statusBarHeigth = MediaQuery.of(context).viewPadding.top;
    double regionOffset = (150 - statusBarHeigth - shrinkOffset).clamp(0, 30);
    double regionOpacity = (regionOffset / 30);
    double statsOffset = (150 + statusBarHeigth - shrinkOffset).clamp(0, 50);
    double statsOpacity = (statsOffset / 50);

    return Container(
      decoration: BoxDecoration(
        color: AppThemes.xploreAppbarColor(Theme.of(context).brightness),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2.0,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: regionOpacity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 16,
                    // size: theme.textTheme.labelSmall?.fontSize,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "region",
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      // style: TextStyle(
                      //   fontSize: 13,
                      //   color: Colors.grey[700],
                      // ),
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Place with long name and history",
                  textAlign: TextAlign.left,
                  // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Opacity(
              opacity: statsOpacity,
              child: Visibility(
                visible: statsOpacity > 0.6,
                replacement: const SizedBox.shrink(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.zero,
                          itemSize: 18,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // print(rating);
                          },
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "4 (180)",
                          style: theme.textTheme.labelLarge,
                        ),
                      ],
                    ),
                    CustomDivider(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 3,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    Text(
                      "subcategory · {widget.place.category}",
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      // style: TextStyle(
                      //   fontSize: 13,
                      //   color: Colors.grey[700],
                      // ),
                      style: theme.textTheme.labelMedium,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
