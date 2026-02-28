import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ButtonComponent extends StatelessWidget {
  final VoidCallback? OnTap;
  final String label;
  final Color? labelColor;
  final Color? BtnColor;
  final bool isLoading;
  final double? width;

  const ButtonComponent({super.key, this.OnTap, required this.label, this.labelColor, this.BtnColor, required this.isLoading, this.width});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = BtnColor ?? colorScheme.primary;
    final fgColor = labelColor ?? colorScheme.onPrimary;

    return GestureDetector(
      onTap: OnTap,
      child: Container(
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: isLoading
                ? SpinKitThreeBounce(color: fgColor, size: 20.0)
                : Text(label, style: TextStyle(color: fgColor)),
          ),
        ),
      ),
    );
  }
}