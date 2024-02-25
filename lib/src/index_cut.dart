import 'dart:math';

import 'package:flutter/material.dart';

/// This widget represents a screen like an index cut
class IndexCut extends StatelessWidget {
  /// - `currentIndex`: The current index that is selected.
  /// - `icons`: A list of icons to display as tabs.
  /// - `isOneWay`: If true, tabs before the current index are not displayed.
  /// - `height`: The height of the tabs area.
  /// - `curveRadius`: The radius of the curve on the selected tab's cut.
  /// - `shadowColor`: The color of the shadow below the cut.
  /// - `onChanged`: Callback function that is called when a new tab is selected.
  /// - `child`: The content displayed below the tabs area.
  const IndexCut({
    super.key,
    required this.currentIndex,
    required this.icons,
    this.isOneWay = false,
    this.height = 60.0,
    this.curveRadius = 20.0,
    this.shadowColor = Colors.grey,
    required this.onChanged,
    required this.child,
  });

  final int currentIndex;
  final List<Widget> icons;
  final bool isOneWay;
  final double height;
  final double curveRadius;
  final Color shadowColor;
  final ValueChanged<int> onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: IndexCutPainter(
        itemCount: icons.length,
        currentIndex: currentIndex,
        isOneWay: isOneWay,
        height: height,
        curveRadius: curveRadius,
        shadowColor: shadowColor,
      ),
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var i = 0; i < icons.length; i++) ...{
                  Expanded(
                    child: isOneWay && i < currentIndex
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => onChanged(i),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: icons[i],
                              ),
                            ),
                          ),
                  )
                }
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class IndexCutPainter extends CustomPainter {
  const IndexCutPainter({
    required this.itemCount,
    required this.currentIndex,
    required this.isOneWay,
    required this.height,
    required this.curveRadius,
    required this.shadowColor,
  }) : assert(currentIndex <= itemCount - 1);

  final int itemCount;
  final int currentIndex;
  final bool isOneWay;
  final double height;
  final double curveRadius;
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final shadowColor = this.shadowColor.withOpacity(1 / itemCount);

    for (var index = 0; index < itemCount; index++) {
      if (index < currentIndex && !isOneWay) {
        final end = size.width * (index + 1) / itemCount;
        final rect = Rect.fromPoints(
          Offset(end - curveRadius * 2, height),
          Offset(end, height - curveRadius * 2),
        );
        final path = Path()
          ..lineTo(0, height)
          ..lineTo(end - curveRadius, height)
          ..lineTo(end, height - curveRadius)
          ..lineTo(end, 0)
          ..close()
          ..addArc(rect, 0, pi / 2);
        canvas.drawShadow(path, shadowColor, 1, true);
      }

      if (index > currentIndex) {
        final start = size.width * index / itemCount;
        final rect = Rect.fromPoints(
          Offset(start, height - curveRadius * 2),
          Offset(start + curveRadius * 2, height),
        );

        final path = Path()
          ..moveTo(start, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, height)
          ..lineTo(start + curveRadius, height)
          ..lineTo(start, height - curveRadius)
          ..close()
          ..addArc(rect, pi / 2, pi);

        canvas.drawShadow(path, shadowColor, 1, true);
      }

      if (index == currentIndex) {
        final curveRadius = this.curveRadius / 2;
        final start = size.width * index / itemCount;
        final end = size.width * (index + 1) / itemCount;
        final leftRect = Rect.fromPoints(
          Offset(start, 0),
          Offset(start + curveRadius * 2, curveRadius * 2),
        );
        final rightRect = Rect.fromPoints(
          Offset(end, 0),
          Offset(end - 2 * curveRadius, 2 * curveRadius),
        );

        final path = Path()..fillType = PathFillType.evenOdd;

        if (!isOneWay) {
          path
            ..arcTo(leftRect, pi, pi / 2, true)
            ..moveTo(start, 0)
            ..lineTo(start, curveRadius)
            ..lineTo(start + curveRadius, 0)
            ..close();
        }

        path
          ..arcTo(rightRect, pi * 3 / 2, pi / 2, true)
          ..moveTo(end, 0)
          ..lineTo(end, curveRadius)
          ..lineTo(end - curveRadius, 0);

        canvas.drawShadow(path, shadowColor, 1, true);
      }
    }
  }

  @override
  bool shouldRepaint(IndexCutPainter oldDelegate) {
    return true;
  }
}