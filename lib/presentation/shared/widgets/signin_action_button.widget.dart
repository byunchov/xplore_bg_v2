import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class SigninActionButton extends StatefulWidget {
  final double btnHeight;
  final Color color;
  final String text;
  final IconData icon;
  final AsyncCallback onPressed;

  const SigninActionButton({
    Key? key,
    this.btnHeight = 50.0,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SigninActionButton> createState() => _SigninActionButtonState();
}

class _SigninActionButtonState extends State<SigninActionButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      child: Visibility(
        visible: !_isLoading,
        replacement: Center(
          child: SizedBox.square(
            dimension: widget.btnHeight * 0.55,
            child: CircularProgressIndicator.adaptive(
              // backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(widget.icon),
            CustomDivider(
              height: widget.btnHeight * 0.36,
              width: 1,
              color: Colors.grey[350],
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            Text(widget.text),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 3,
        fixedSize: Size(double.infinity, widget.btnHeight),
        primary: widget.color,
        onSurface: widget.color,
      ),
      onPressed: _isLoading
          ? null
          : () async {
              setState(() => _isLoading = true);
              await widget.onPressed();
              setState(() => _isLoading = false);
            },
    );
  }
}
