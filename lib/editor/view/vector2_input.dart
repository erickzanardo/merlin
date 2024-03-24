import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Vector2InputController {
  String _x = '';
  String _y = '';

  Vector2? get value {
    final x = double.tryParse(_x);
    final y = double.tryParse(_y);
    if (x == null || y == null) {
      return null;
    }

    return Vector2(x, y);
  }

  set value(Vector2? value) {
    if (value == null) {
      _x = '';
      _y = '';
    } else {
      _x = value.x.toString();
      _y = value.y.toString();
    }
  }
}

class Vector2Input extends StatefulWidget {
  const Vector2Input({
    required this.controller,
    super.key,
  });

  final Vector2InputController controller;

  @override
  State<Vector2Input> createState() => _Vector2InputState();
}

class _Vector2InputState extends State<Vector2Input> {
  late final _xController = TextEditingController();
  late final _yController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final widgetValue = widget.controller.value;
    if (widgetValue != null) {
      _xController.text = widgetValue.x.toString();
      _yController.text = widgetValue.y.toString();
    }

    _xController.addListener(() {
      widget.controller._x = _xController.text;
      setState(() {});
    });

    _yController.addListener(() {
      widget.controller._y = _yController.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _xController.dispose();
    _yController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _xController,
            decoration: InputDecoration(
              hintText: 'X',
              errorText: double.tryParse(widget.controller._x) == null
                  ? 'Invalid number'
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text('X'),
        const SizedBox(width: 8),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _yController,
            decoration: InputDecoration(
              hintText: 'Y',
              errorText: double.tryParse(widget.controller._y) == null
                  ? 'Invalid number'
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
