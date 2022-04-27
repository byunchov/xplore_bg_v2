import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/category.model.dart';
import 'package:xplore_bg_v2/presentation/category/category.screen.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel categoryItem;
  final double cardRadius;
  final double elevation;
  final VoidCallback? onPressed;

  const CategoryCard({
    Key? key,
    required this.categoryItem,
    this.cardRadius = 15,
    this.elevation = 6,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(cardRadius),
            child: CustomCachedImage(imageUrl: categoryItem.thumbnail),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.1),
                ],
              ),
            ),
          ),
          //item count label
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[700]?.withOpacity(0.95),
                ),
                child: Text(
                  categoryItem.itemCount.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          // category name
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                categoryItem.name,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(cardRadius),
                onTap: onPressed ??
                    () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: ((context) => CategoryScreen(category: categoryItem)),
                      // ));
                      // context.router
                      //     .navigate(CategoryRoute(id: categoryItem.tag!, category: categoryItem));

                      // context.pushRoute(HomeRoute(children: [
                      //   LandmarkCategoriesRoute(children: [
                      //     CategoryRoute(id: categoryItem.tag!, category: categoryItem)
                      //   ])
                      // ]));
                    },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel categoryItem;
  final double cardRadius;

  const _CategoryCard({
    Key? key,
    required this.categoryItem,
    this.cardRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.5,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Ink(
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius),
                child: CustomCachedImage(imageUrl: categoryItem.thumbnail),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardRadius),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              //item count label
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[700]?.withOpacity(0.95),
                    ),
                    child: Text(
                      categoryItem.itemCount.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              // category name
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    categoryItem.name,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
