import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/editor/editor.dart';
import 'package:merlin_editor/project/project.dart';
import 'package:nes_ui/nes_ui.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const AppPage());
  }

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) {
        return current != previous && current is LoadedAppState;
      },
      listener: (BuildContext context, state) {
        Navigator.pushReplacement(
          context,
          EditorPage.route(),
        );
      },
      child: const AppEmptyView(),
    );
  }
}

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NesContainer(
          width: 400,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NesButton(
                type: NesButtonType.primary,
                onPressed: () {
                  context.read<AppCubit>().loadProject();
                },
                child: const Text('Load Project'),
              ),
              NesButton(
                type: NesButtonType.normal,
                onPressed: () async {
                  final cubit = context.read<AppCubit>();
                  final data = await ProjectForm.show(null, context);
                  if (data != null) {
                    await cubit.createProject(data);
                  }
                },
                child: const Text('New Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
