import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merlin/merlin.dart';
import 'package:nes_ui/nes_ui.dart';

class ProjectForm extends StatefulWidget {
  const ProjectForm({
    this.gameData,
    super.key,
  });

  final MerlinGameData? gameData;

  static Future<MerlinGameData?> show(
    MerlinGameData? gameData,
    BuildContext context,
  ) {
    return NesDialog.show<MerlinGameData>(
      context: context,
      frame: const NesWindowDialogFrame(),
      builder: (context) {
        return ProjectForm(gameData: gameData);
      },
    );
  }

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  late final _isNewProject = widget.gameData == null;

  late final _nameController = TextEditingController(
    text: widget.gameData?.name,
  );
  late final _resolutionWidthController = TextEditingController(
    text: widget.gameData?.resolutionWidth.toString(),
  );
  late final _resolutionHeightController = TextEditingController(
    text: widget.gameData?.resolutionHeight.toString(),
  );
  late final _gridSizeController = TextEditingController(
    text: widget.gameData?.gridSize.toString(),
  );

  var _errors = <String, String>{};

  MerlinGameData? _save() {
    final errors = <String, String>{};
    final name = _nameController.text;
    if (name.isEmpty) {
      errors['name'] = 'Name is required';
    }

    final resolutionWidth = _resolutionWidthController.text;
    if (resolutionWidth.isEmpty) {
      errors['resolutionWidth'] = 'Resolution Width is required';
    }

    final resolutionHeight = _resolutionHeightController.text;
    if (resolutionHeight.isEmpty) {
      errors['resolutionHeight'] = 'Resolution Height is required';
    }

    final gridSize = _gridSizeController.text;
    if (gridSize.isEmpty) {
      errors['gridSize'] = 'Grid Size is required';
    }

    if (errors.isNotEmpty) {
      setState(() {
        _errors = errors;
      });
      return null;
    }

    return MerlinGameData(
      name: name,
      resolutionWidth: int.parse(resolutionWidth),
      resolutionHeight: int.parse(
        resolutionHeight,
      ),
      gridSize: int.parse(gridSize),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          NesSectionHeader(title: '${_isNewProject ? 'New' : 'Edit'} Project'),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: _errors['name'],
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _resolutionWidthController,
            decoration: InputDecoration(
              labelText: 'Resolution Width',
              errorText: _errors['resolutionWidth'],
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _resolutionHeightController,
            decoration: InputDecoration(
              labelText: 'Resolution Height',
              errorText: _errors['resolutionHeight'],
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _gridSizeController,
            decoration: InputDecoration(
              labelText: 'Grid Size',
              errorText: _errors['gridSize'],
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
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
                  final gameData = _save();
                  if (gameData != null) {
                    Navigator.of(context).pop(gameData);
                  }
                },
                child: Text(_isNewProject ? 'Create' : 'Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
