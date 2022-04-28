import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/models/swipe_action.model.dart';
import 'package:xplore_bg_v2/presentation/shared/places/place_action_dialog.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/places/place_list_tile.widget.dart';

class PlaceSwipeListTile extends StatelessWidget {
  final PlaceModel placePreview;
  final List<SwipeActionModel>? actions;
  final double widthSpace;

  const PlaceSwipeListTile({
    Key? key,
    required this.placePreview,
    this.actions,
    this.widthSpace = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: UniqueKey(),
      trailingActions: actions?.map((action) {
        return SwipeAction(
          widthSpace: widthSpace,
          content: action.child,
          color: Colors.transparent,
          onTap: (CompletionHandler handler) async {
            // await handler(true);
            await action.onTap?.call();
            await handler(false);
          },
        );
      }).toList(),
      child: PlaceListTile(
        placePreview: placePreview,
        onLongPress: () => _onLongPress(context),
      ),
    );
  }

  void _onLongPress(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => PlaceActionDialog(
        id: placePreview.id,
        name: placePreview.name,
      ),
    );
  }
}
