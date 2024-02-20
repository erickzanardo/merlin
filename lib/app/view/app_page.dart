import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin_editor/app/app.dart';
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
    final appCubit = context.watch<AppCubit>();
    final state = appCubit.state;

    if (state is LoadedAppState) {
      return Scaffold(
        body: Text(state.gameData.name),
      );
    } else {
      return const AppEmptyView();
    }
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
                onPressed: () {},
                child: const Text('New Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
