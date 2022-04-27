import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PlaceDetailsScreen extends StatefulWidget {
  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  Color _statusBarColor = Colors.transparent;

  Widget build1(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double panelHeightOpen = screenHeight - statusBarHeight;
    double panelHeightClosed = screenHeight - 320;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: panelHeightOpen,
            minHeight: panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            body: _body(context),
            panelBuilder: (sc) => _panel(context, sc),
            onPanelSlide: (double pos) => setState(() {
              if (pos == 1.0) {
                _statusBarColor = Colors.white;
              } else if (pos == 0.0) {
                _statusBarColor = Colors.transparent;
              }
            }),
          ),
          // Status bar color
          Positioned(
            top: 0,
            child: ClipRRect(
              child: Container(
                width: screenWidth,
                height: statusBarHeight,
                color: _statusBarColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel(BuildContext context, ScrollController sc) {
    final theme = Theme.of(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(child: _PanelHeader()),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              controller: sc,
              child: Column(
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      title: Text("Item $index"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        const Hero(
          tag: "tag2345",
          child: CustomCachedImage(imageUrl: "https://source.unsplash.com/random?mono+dark"),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: SafeArea(
            child: Material(
              // color: Colors.transparent,
              child: IconButton(
                icon: const Icon(
                  Feather.arrow_left,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          /* SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Title"),
              background: CachedNetworkImage(
                imageUrl: AppConfig.defaultProfilePic,
              ),
            ),
          ), */
          /* TransitionAppBar(
            extent: 250,
            avatar: Text("Rancho"),
            title: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              decoration: BoxDecoration(
                  color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.black,
                    autofocus: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        hintText: "Search",
                        border: InputBorder.none,
                        disabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.transparent),
                          borderRadius: new BorderRadius.circular(2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.transparent),
                          borderRadius: new BorderRadius.circular(2),
                        )),
                  ),
                )
              ]),
            ),
          ), */
          // const SliverPersistentHeader(
          //   delegate: CustomSliverAppBarDelegate(expandedHeight: 300),
          //   pinned: true,
          // ),

          // SliverAppBar(
          //   expandedHeight: 480,
          //   pinned: true,
          //   leading: IconButton(
          //     icon: const Icon(Icons.chevron_left),
          //     onPressed: () {},
          //   ),
          //   title: Text("Sample title"),
          //   flexibleSpace: const FlexibleSpaceBar(
          //     background: CustomCachedImage(
          //       imageUrl: 'https://source.unsplash.com/random?mono+dark',
          //     ),
          //   ),
          //   bottom: PreferredSize(
          //     preferredSize: const Size.fromHeight(180),
          //     child: _header(context),
          //   ),
          // ),

          const SliverPersistentHeader(
            pinned: true,
            delegate: CustomHeaderDelegate(expandedHeight: 300),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gallery",
                    style: theme.textTheme.titleLarge,
                  ),
                  const CustomDivider(
                    width: 60,
                    height: 3,
                    margin: EdgeInsets.only(top: 10),
                  ),
                ],
              ),
              child: Container(
                height: 200,
                color: Colors.red,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(
                    width: 100,
                    color: Colors.green,
                  ),
                  separatorBuilder: (BuildContext context, int index) => SizedBox(width: 10),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
                color: Colors.blue,
                child: ListTile(
                  title: Text("${index}a"),
                ));
          }, childCount: 25))
        ],
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_pin,
                  size: theme.textTheme.labelMedium?.fontSize,
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
            const SizedBox(height: 15),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Place with long name and history",
                  textAlign: TextAlign.left,
                  // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Column(
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
          ],
        ),
      ),
    );
  }
}

class _PanelBody extends StatelessWidget {
  const _PanelBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container();
  }
}

class CustomHeaderDelegate2 extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  const CustomHeaderDelegate2({this.expandedHeight = 300});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double imgHeight = (150 - shrinkOffset).clamp(0, 150);
    return AnimatedSwitcher(
      duration: kThemeChangeDuration,
      child: Visibility(
        visible: shrinkOffset < 160,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: imgHeight,
              child: CustomCachedImage(imageUrl: "https://source.unsplash.com/random?mono+dark"),
            ),
            Expanded(child: _header(context)),
          ],
        ),
        replacement: _appBar(context),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      title: const Text("Test appbar replacemnet"),
      leading: const Icon(Icons.chevron_left),
      actions: const [Icon(Icons.share)],
    );
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: 15),
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Place with long name and history",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Column(
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
                    const Text("4"),
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
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
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
            ),
            const SizedBox(height: 15),
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Place with long name and history",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
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
                        const Text("4"),
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
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
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

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 60;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),
        buildAppBar(shrinkOffset),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: buildFloating(shrinkOffset, context),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / (expandedHeight);

  double disappear(double shrinkOffset) => 1 - shrinkOffset / (expandedHeight);

  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          title: const Text("Name"),
          leading: const Icon(Icons.chevron_left_outlined),
        ),
      );

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: const CustomCachedImage(
          imageUrl: 'https://source.unsplash.com/random?mono+dark',
        ),
      );

  Widget buildFloating(double shrinkOffset, BuildContext context) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(
          padding: const EdgeInsets.all(15),
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
                  Row(
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
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildButton({
    required String text,
    required IconData icon,
  }) =>
      TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 20)),
          ],
        ),
        onPressed: () {},
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget _header(BuildContext context) {
    return Container(
      height: 100,
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
