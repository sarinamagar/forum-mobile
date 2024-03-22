import 'dart:math';

import 'package:flutter/material.dart';

class SnapPageScrollPhysics extends ScrollPhysics {
  const SnapPageScrollPhysics({
    super.parent,
    required this.elementWidth,
    required this.elementPadding,
  });

  final double elementWidth;
  final double elementPadding;

  @override
  SnapPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnapPageScrollPhysics(
      parent: buildParent(ancestor),
      elementWidth: elementWidth,
      elementPadding: elementPadding,
    );
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    final pageWidth = elementWidth + elementPadding;
    final page = position.pixels / pageWidth + velocity / 3000;
    final offset = (position.viewportDimension - elementWidth) / 2;
    final target = page.roundToDouble() * pageWidth - offset + elementPadding;
    return max(0, min(target, position.maxScrollExtent));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final tolerance = toleranceFor(position);
    final target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
