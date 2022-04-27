import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/place/widgets/action_icons.dart' show IconStyle;

class ActionIconButton extends ConsumerWidget {
  final String id;
  final String field;
  final dynamic iconStyle;
  final VoidCallback onPressed;

  const ActionIconButton({
    Key? key,
    required this.id,
    required this.field,
    required this.iconStyle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          constraints: const BoxConstraints(minWidth: 66),
          color: Colors.transparent,
          child: Column(
            children: [
              if (iconStyle is IconStyle)
                _ActionIcon(
                  id: id,
                  field: field,
                  iconStyle: iconStyle,
                ),
              if (iconStyle is Icon) iconStyle,
              const SizedBox(height: 3),
              _ActionIconText(id: id, field: field),
            ],
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}

class _ActionIcon extends ConsumerWidget {
  final String id;
  final String field;
  final IconStyle iconStyle;

  const _ActionIcon({
    Key? key,
    required this.id,
    required this.field,
    required this.iconStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestore = ref.read(firebaseFirestoreProvider);
    final user = ref.watch(authControllerProvider);

    if (user == null) return iconStyle.regular;

    final collection = field.replaceFirst(RegExp(r"_[\w]*"), 's');
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.doc('users/${user.uid}').collection(collection).snapshots(),
      builder: (ctx, snap) {
        if (!snap.hasData) return iconStyle.regular;
        // final snapshot = snap.data as QuerySnapshot<Map<String, dynamic>>;
        final snapshot = snap.data;
        final result = snapshot?.docs.firstWhereOrNull((element) => element.id == id);

        // print("[$field] $result");

        if (result != null) {
          return iconStyle.bold;
        } else {
          return iconStyle.regular;
        }
      },
    );
  }
}

class _ActionIconText extends StatelessWidget {
  final String id;
  final String field;

  const _ActionIconText({
    Key? key,
    required this.id,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.doc("locations/$id").snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Text('--');
        // final snapshot = snap.data as DocumentSnapshot<Map<String, dynamic>>;
        final data = snap.data;
        final count = data?[field];
        return Text(count.toString());
      },
    );
  }
}
