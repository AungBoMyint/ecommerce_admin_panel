// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uuid/uuid.dart';

class MyGFButton extends GFButton implements Equatable {
  final double dx;
  final double dy;
  const MyGFButton({
    super.key,
    required super.onPressed,
    this.dx = 0,
    this.dy = 0,
    super.shape,
    super.color,
  });

  @override
  List<Object?> get props => [
        dx,
        dy,
        onPressed,
        super.shape,
        super.color,
        super.key,
      ];

  @override
  bool? get stringify => null;

  MyGFButton copyWith({
    double? dx,
    double? dy,
    Key? key,
    GFButtonShape? shape,
    Color? color,
    void Function()? onPressed,
  }) {
    return MyGFButton(
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
      key: key ?? this.key,
      shape: shape ?? this.shape,
      color: color ?? this.color,
      onPressed: onPressed ?? this.onPressed,
    );
  }
}

List<MyGFButton> buttons = [
  ...GFButtonShape.values.map((e) => MyGFButton(
        key: Key(Uuid().v4()),
        onPressed: () {},
        shape: e,
        color: GFColors.ALT,
      )),
  ...GFButtonShape.values.map((e) => MyGFButton(
        key: Key(Uuid().v4()),
        onPressed: () {},
        shape: e,
        color: GFColors.DANGER,
      )),
  ...GFButtonShape.values.map((e) => MyGFButton(
        key: Key(Uuid().v4()),
        onPressed: () {},
        shape: e,
        color: GFColors.DARK,
      )),
  ...GFButtonShape.values.map((e) => MyGFButton(
        key: Key(Uuid().v4()),
        onPressed: () {},
        shape: e,
        color: GFColors.FOCUS,
      )),
  ...GFButtonShape.values.map((e) => MyGFButton(
        key: Key(Uuid().v4()),
        onPressed: () {},
        shape: e,
        color: GFColors.INFO,
      )),
];
