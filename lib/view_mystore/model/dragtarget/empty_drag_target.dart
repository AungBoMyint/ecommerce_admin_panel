import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EmptyDragTarget<T extends StatefulWidget> extends DragTarget<T> {
  EmptyDragTarget({
    super.key,
    required double height,
    required double width,
    super.onAccept,
    T? acceptedValue,
  }) : super(
          builder: (context, items, __) {
            return acceptedValue ??
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: SizedBox(
                    height: height,
                    width: width,
                  ),
                );
          },
          onWillAccept: (t) => true,
        );
}

class ValueDragTarget<T extends StatefulWidget> extends DragTarget<T> {
  ValueDragTarget({
    super.key,
    super.onAccept,
    T? acceptedValue,
    required Widget child,
  }) : super(
          builder: (context, items, __) {
            return acceptedValue ??
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: child,
                );
          },
          onWillAccept: (v) => v is T,
        );
}
