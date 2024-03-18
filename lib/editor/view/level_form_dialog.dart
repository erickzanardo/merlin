import 'package:flutter/material.dart';
import 'package:merlin/merlin.dart';
import 'package:nes_ui/nes_ui.dart';

class LevelFormDialog extends StatefulWidget {
  const LevelFormDialog({
    this.level,
    super.key,
  });

  final MerlinGameLevel? level;

  static Future<(String, MerlinGameLevel)?> show(
    BuildContext context, {
    MerlinGameLevel? level,
  }) async {
    return NesDialog.show(
      context: context,
      frame: const NesWindowDialogFrame(),
      builder: (context) {
        return LevelFormDialog(
          level: level,
        );
      },
    );
  }

  @override
  State<LevelFormDialog> createState() => _LevelFormDialogState();
}

class _LevelFormDialogState extends State<LevelFormDialog> {
  final _nameController = TextEditingController();
  final _speedController = TextEditingController();
  final _lengthController = TextEditingController();

  late final bool _isNewLevel = widget.level == null;
  var _errors = <String, String>{};

  (String, MerlinGameLevel)? _save() {
    final errors = <String, String>{};
    final name = _nameController.text;
    if (name.isEmpty) {
      errors['name'] = 'Name is required';
    }

    final speed = double.tryParse(_speedController.text);
    if (speed == null) {
      errors['speed'] = 'Speed is not a valid double';
    }

    final length = double.tryParse(_lengthController.text);
    if (length == null) {
      errors['length'] = 'Length is not a valid double';
    }
    if (errors.isNotEmpty) {
      setState(() {
        _errors = errors;
      });
      return null;
    }

    return (
      name,
      MerlinGameLevel(
        scrollSpeed: speed!,
        scrollLength: length!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          NesSectionHeader(title: '${_isNewLevel ? 'New' : 'Edit'} Level'),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: _errors['name'],
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _speedController,
            decoration: InputDecoration(
              labelText: 'Speed',
              errorText: _errors['speed'],
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lengthController,
            decoration: InputDecoration(
              labelText: 'Length',
              errorText: _errors['length'],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NesButton(
                type: NesButtonType.normal,
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 16),
              NesButton(
                type: NesButtonType.primary,
                onPressed: () {
                  final levelData = _save();
                  if (levelData != null) {
                    Navigator.of(context).pop(
                      levelData,
                    );
                  }
                },
                child: Text(_isNewLevel ? 'Create' : 'Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
