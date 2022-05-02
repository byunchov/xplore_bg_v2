import 'package:flutter/material.dart';

class PlaceActivitiyColorCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final double cardHeight;
  final double cardRadius;
  final VoidCallback? callback;

  const PlaceActivitiyColorCard({
    Key? key,
    required this.text,
    required this.icon,
    this.color = Colors.blueAccent,
    this.cardHeight = 150,
    this.cardRadius = 10,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius),
              color: color,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Center(child: Icon(icon, color: Colors.black)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                text,
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
                onTap: callback ?? () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PlaceActivityImageCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget image;
  final double cardHeight;
  final double cardRadius;
  final VoidCallback? callback;

  const PlaceActivityImageCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.image,
    this.cardHeight = 160,
    this.cardRadius = 10,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cardRadius),
              child: image,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Center(child: Icon(icon, color: Colors.black)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                text,
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
                onTap: callback ?? () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
