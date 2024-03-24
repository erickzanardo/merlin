import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merlin/merlin.dart';
import 'package:nes_ui/nes_ui.dart';

class EnemyFormDialog extends StatefulWidget {
  const EnemyFormDialog({
    this.enemy,
    super.key,
  });

  final MerlinEnemy? enemy;

  static Future<(String, MerlinEnemy)?> show(
    BuildContext context, {
    MerlinEnemy? enemy,
  }) async {
    return NesDialog.show(
      context: context,
      frame: const NesWindowDialogFrame(),
      builder: (context) {
        return EnemyFormDialog(
          enemy: enemy,
        );
      },
    );
  }

  @override
  State<EnemyFormDialog> createState() => _EnemyFormDialogState();
}

class _EnemyFormDialogState extends State<EnemyFormDialog> {
  final _nameController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  late final bool _isNewEnemy = widget.enemy == null;
  var _errors = <String, String>{};

  MerlinEnemy? _save() {
    final errors = <String, String>{};
    final name = _nameController.text;
    if (name.isEmpty) {
      errors['name'] = 'Name is required';
    }

    final width = int.tryParse(_widthController.text);
    if (width == null) {
      errors['width'] = 'Width is not a valid int';
    }

    final height = int.tryParse(_heightController.text);
    if (height == null) {
      errors['height'] = 'Height is not a valid int';
    }
    if (errors.isNotEmpty) {
      setState(() {
        _errors = errors;
      });
      return null;
    }

    return MerlinEnemy(
      name: name,
      // TODO
      asset: const MerlinSpriteAsset(
        path: 'assets/enemy.png',
      ),
      width: width!,
      height: height!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          NesSectionHeader(title: '${_isNewEnemy ? 'New' : 'Edit'} Enemy'),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: _errors['name'],
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _widthController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              labelText: 'Width',
              errorText: _errors['width'],
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _heightController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              labelText: 'Height',
              errorText: _errors['height'],
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
                  final enemyData = _save();
                  if (enemyData != null) {
                    Navigator.of(context).pop(
                      enemyData,
                    );
                  }
                },
                child: Text(_isNewEnemy ? 'Create' : 'Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
