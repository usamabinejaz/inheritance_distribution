import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

ResponsiveGridCol fullWidthResponsiveField({required List<Widget> children}) {
  return ResponsiveGridCol(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: children,
      ),
    ),
  );
}

ResponsiveGridCol formResponsiveField({required Widget child, bool? visible}) {
  return ResponsiveGridCol(
    lg: 6,
    xl: 6,
    md: 6,
    sm: 12,
    xs: 12,
    child: Visibility(
      visible: visible ?? true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    ),
  );
}
