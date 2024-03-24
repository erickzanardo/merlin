import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin/merlin.dart';
import 'package:merlin_editor/clients/clients.dart';
import 'package:nes_ui/nes_ui.dart';

class AssetFormView extends StatefulWidget {
  const AssetFormView({
    this.asset,
    super.key,
  });

  final MerlinAsset? asset;

  @override
  State<AssetFormView> createState() => _AssetFormViewState();
}

class _AssetFormViewState extends State<AssetFormView> {
  late String? _path = widget.asset?.path;

  late String? _type;

  @override
  void initState() {
    super.initState();

    // TODO(erickzanardo): Add support for other asset types.
    //if (widget.asset is MerlinSpriteAsset) {
    _type = 'Sprite';
    //}
  }

  void _selectFile() async {
  }

  @override
  Widget build(BuildContext context) {
    final dataClient  = context.read<DataClient>();
    // TODO(erickzanardo): Finish this
    return Column(
      children: [
        if (_path == null)
          Row(
            children: [
              const Text('No file selected'),
              const SizedBox(width: 8),
              NesButton.icon(
                type: NesButtonType.normal,
                icon: NesIcons.upload,
              onPressed: _selectFile,
              ),
            ],
          ),
      ],
    );
  }
}
