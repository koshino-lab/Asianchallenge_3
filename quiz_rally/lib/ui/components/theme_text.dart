import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';

class _ThemeText extends StatelessWidget {
  const _ThemeText(
    this.text,
    this.size, {
    super.key,
    required this.color,
    required this.weight,
    this.overflow,
    this.maxLines,
    this.decoration,
  });

  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final fontFamily = Theme.of(context).textTheme.bodyLarge!.fontFamily!;
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: weight,
        color: color,
        fontSize: size,
        fontFamily: fontFamily,
        height: 1.5,
        overflow: overflow,
        decoration: decoration,
      ),
    );
  }
}

class GrayText extends _ThemeText {
  const GrayText(
    super.text,
    super.size, {
    super.key,
  }) : super(color: Styles.commonTextColor, weight: FontWeight.w400);

  const GrayText.bold(
    super.text,
    super.size, {
    super.key,
  }) : super(color: Styles.commonTextColor, weight: FontWeight.w700);
}

class WhiteText extends _ThemeText {
  const WhiteText(
    super.text,
    super.size, {
    super.key,
  }) : super(color: Styles.secondaryTextColor, weight: FontWeight.w400);

  const WhiteText.bold(
    super.text,
    super.size, {
    super.key,
  }) : super(color: Styles.secondaryTextColor, weight: FontWeight.w700);
}
