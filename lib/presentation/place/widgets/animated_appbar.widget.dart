import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class TransitionAppBar extends StatelessWidget {
  final Widget avatar;
  final Widget title;
  final double extent;

  const TransitionAppBar({required this.avatar, required this.title, this.extent = 250, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 70, left: 30),
      end: const EdgeInsets.only(left: 0.0, top: 30.0));
  final _avatarAlignTween = AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topCenter);

  final Widget avatar;
  final Widget title;
  final double extent;

  _TransitionAppBarDelegate({required this.avatar, required this.title, this.extent = 250})
      : assert(extent >= 200);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    print("Objechjkf === $progress $shrinkOffset");
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);

    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).viewPadding.top,
          left: 0,
          child: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {},
          ),
        ),
        // AnimatedContainer(
        //   duration: const Duration(milliseconds: 100),
        //   height: shrinkOffset * 2,
        //   constraints: BoxConstraints(maxHeight: minExtent),
        //   color: Colors.redAccent,
        // ),
        Padding(
          padding: avatarMargin,
          child: Align(alignment: avatarAlign, child: avatar),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: title,
          ),
        ),
        _header(context),
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => (maxExtent * 68) / 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }

  Widget _header(BuildContext context) {
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
          children: [
            Row(
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
                  child: Text(
                    "region",
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        "Place with long name and history",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900, color: Colors.grey[800]),
                      ),
                      const SizedBox(height: 5),
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
                          const Text("4"),
                        ],
                      ),
                      CustomDivider(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "subcategory · {widget.place.category}",
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                AnimatedSize(
                  duration: const Duration(milliseconds: 150),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.heart_broken),
                            onPressed: () {},
                          ),
                          const Text("999"),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.heart_broken),
                            onPressed: () {},
                          ),
                          const Text("999"),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.heart_broken),
                            onPressed: () {},
                          ),
                          const Text("999"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
