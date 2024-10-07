import 'package:flutter/material.dart';

extension PriceDisplayExtension on String? {
  String getDisplayPrice() {
    return this == null ? "" : "\$${this!}";
  }
}

extension WidgetExtension on Widget {
  Widget addMarginLTRB(
      {double? left, double? top, double? right, double? bottom}) {
    return Container(
      margin: EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0),
      child: this,
    );
  }

  Widget addMarginAll(double? all) {
    return addMarginLTRB(left: all, top: all, right: all, bottom: all);
  }

  Widget addMarginSymmetric({double? horizontal, double? vertical}) {
    return addMarginLTRB(
        left: horizontal, top: vertical, right: horizontal, bottom: vertical);
  }

  Widget addPaddingLTRB(
      {double? left, double? top, double? right, double? bottom}) {
    return Container(
      padding:
      EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0),
      child: this,
    );
  }

  Widget addPaddingAll(double all) {
    return addPaddingLTRB(left: all, top: all, right: all, bottom: all);
  }

  Widget addPaddingSymmetric({double? horizontal, double? vertical}) {
    return addPaddingLTRB(
        left: horizontal, top: vertical, right: horizontal, bottom: vertical);
  }

  Widget expandBy(int flex) {
    return Expanded(flex: flex, child: this);
  }
}
