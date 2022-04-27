import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/models/location.model.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class LocationHeaderWidget extends StatefulWidget {
  final LocationModel location;
  final ScrollController controller;
  final double scrollOffset;

  const LocationHeaderWidget({
    Key? key,
    required this.location,
    required this.controller,
    this.scrollOffset = 300,
  }) : super(key: key);

  @override
  State<LocationHeaderWidget> createState() => _LocationHeaderWidgetState();
}

class _LocationHeaderWidgetState extends State<LocationHeaderWidget> {
  final Duration _kResizeDuration = const Duration(milliseconds: 500);
  final Duration _kSwapDuration = const Duration(milliseconds: 200);
  bool _shrinkContainer = false;
  late Widget _widget;
  late Widget _expanded;
  late Widget _collapsed;

  @override
  void initState() {
    _expanded = _LocationHeaderWidgetExpanded(
      location: widget.location,
    );
    _collapsed = Builder(builder: (context) {
      final statusBarHeight = MediaQuery.of(context).viewPadding.top;
      final theme = Theme.of(context);

      return Column(
        children: [
          SizedBox(height: statusBarHeight),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppbarActionWidget(
                    iconData: Icons.arrow_back,
                    buttonSize: 42,
                    onTap: () => context.router.pop(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MarqueeWidget(
                      child: Text(
                        widget.location.name,
                        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
    _widget = _expanded;
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
    final collapseExtent = widget.scrollOffset + widget.scrollOffset * 0.02;
    if (position <= collapseExtent) {
      forwardSwap();
    } else {
      reverseSwap();
    }
  }

  void forwardSwap() {
    if (_shrinkContainer) {
      setState(() {
        _shrinkContainer = false;
        _widget = _expanded;
      });
    }
  }

  void reverseSwap() {
    if (!_shrinkContainer) {
      setState(() {
        _shrinkContainer = true;
        _widget = _collapsed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final collapsedAppBarHeight = theme.appBarTheme.toolbarHeight! + statusBarHeight;

    return AnimatedContainer(
      height: _shrinkContainer ? collapsedAppBarHeight : 150,
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
      duration: _kResizeDuration,
      child: AnimatedSwitcher(
        duration: _kSwapDuration,
        reverseDuration: _kSwapDuration,
        child: _widget,
      ),
    );
  }
}

class _LocationHeaderWidgetExpanded extends StatelessWidget {
  // final String locationName;
  // final String locationAddres;
  // final String category;
  // final String subcategory;
  // final double rating;
  // final int reviewsCount;
  final LocationModel location;

  const _LocationHeaderWidgetExpanded({
    Key? key,
    required this.location,
    // required this.locationName,
    // required this.locationAddres,
    // required this.category,
    // required this.subcategory,
    // required this.rating,
    // required this.reviewsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_pin,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: MarqueeWidget(
                    child: Text(
                      location.residence!,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 5),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: MarqueeWidget(
                child: Text(
                  location.name,
                  textAlign: TextAlign.left,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                RatingBar.builder(
                  initialRating: location.rating,
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
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(width: 5),
                Text(
                  "${location.rating} (${location.reviewsCount})",
                  style: theme.textTheme.labelLarge,
                ),
              ],
            ),
          ),
          CustomDivider(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 3,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Expanded(
            // "subcategory · category",
            child: Row(
              children: [
                Text(
                  location.subcategory!,
                  style: theme.textTheme.labelMedium,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.2),
                  child: Icon(
                    Icons.circle,
                    size: 3.8,
                  ),
                ),
                Expanded(
                  child: Text(
                    location.category!,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
