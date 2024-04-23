import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NumberInputWithIncrementDecrement extends StatefulWidget {
  final int initialValue;
  const NumberInputWithIncrementDecrement({super.key, this.initialValue = 0});

  @override
  // ignore: library_private_types_in_public_api
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void increment() {
    int currentValue = int.parse(_controller.text);
    setState(() {
      _controller.text = (currentValue + 1).toString();
    });
  }

  void decrement() {
    int currentValue = int.parse(_controller.text);
    setState(() {
      if (currentValue > 0) {
        _controller.text = (currentValue - 1).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(),
        suffixIconConstraints: const BoxConstraints(maxHeight: 35),
        suffix: LayoutBuilder(builder: (context, constraints) {
          return Container(
            color: Colors.red,
            alignment: Alignment.center,
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                    onTap: increment,
                    child: const Icon(
                      FontAwesomeIcons.chevronUp,
                      size: 15,
                    )),
                InkWell(
                    onTap: decrement,
                    child: const Icon(
                      FontAwesomeIcons.chevronDown,
                      size: 15,
                    )),
              ],
            ),
          );
        }),
      ),
    );
  }
}
