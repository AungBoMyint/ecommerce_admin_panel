import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/view_mystore/model/draggable/button_draggable.dart';
import 'package:ecommerce_admin/view_mystore/model/dragtarget/empty_drag_target.dart';
import 'package:ecommerce_admin/view_mystore/presentation/widgets/appbar/my_app_bar.dart';
import 'package:ecommerce_admin/view_mystore/presentation/widgets/frame/phone_frame_painter.dart';
import 'package:flutter/material.dart';

class ViewMyStore extends StatefulWidget {
  const ViewMyStore({super.key});

  @override
  State<ViewMyStore> createState() => _ViewMyStoreState();
}

class _ViewMyStoreState extends State<ViewMyStore> {
  List<Draggable<MyAppBar>> buttonsOutsideFrame = [
    ...[AppBar1(), AppBar2()].map((e) => e.toDraggable()),
  ];
  Draggable<MyAppBar>? buttonsInsideFrame;

  void changeOutsideFrame(MyAppBar v) {
    buttonsOutsideFrame.add(v.toDraggable());
    buttonsInsideFrame = null;
    setState(() {});
  }

  void changeInsideFrame(MyAppBar v) {
    buttonsOutsideFrame.removeWhere((element) => v.key == element.child.key);
    buttonsInsideFrame = v.toDraggable();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                DragTarget<MyAppBar>(
                    onWillAccept: (v) => true,
                    onAcceptWithDetails: (v) => changeOutsideFrame(v.data),
                    builder: (context, _, __) {
                      return Wrap(
                        children: [...buttonsOutsideFrame],
                      );
                    }),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: CustomPaint(
                size: const Size(360, 640),
                painter: PhoneFramePainter(),
                child: SizedBox(
                  height: 640,
                  width: 360,
                  child: LayoutBuilder(builder: (context, constraints) {
                    final maxHeight = constraints.maxHeight;
                    final maxWidth = constraints.maxWidth;
                    return Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            child: SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: DragTarget<MyAppBar>(
                                  onWillAccept: (v) => true,
                                  onAcceptWithDetails: (v) {
                                    log("Accepted With Detail: ${v.data}");
                                    changeInsideFrame(v.data);
                                  },
                                  builder: (context, _, __) {
                                    return buttonsInsideFrame ??
                                        const SizedBox(
                                          width: double.infinity,
                                        );
                                  }),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
