import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/clients/clients.dart';
import 'package:merlin_editor/repositories/repositories.dart';
import 'package:nes_ui/nes_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dataClient = DataClient();
  final gameDataRepository = GameDataRepository(dataClient: dataClient);
  runApp(
    App(
      dataClient: dataClient,
      gameDataRepository: gameDataRepository,
    ),
  );
}

class App extends StatelessWidget {
  const App({
    required this.dataClient,
    required this.gameDataRepository,
    super.key,
  });

  final DataClient dataClient;
  final GameDataRepository gameDataRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: dataClient),
        RepositoryProvider.value(value: gameDataRepository),
      ],
      child: BlocProvider(
        create: (_) => AppCubit(
          dataClient: dataClient,
          gameDataRepository: gameDataRepository,
        ),
        child: MaterialApp(
          theme: flutterNesTheme(brightness: Brightness.dark),
          home: const AppPage(),
        ),
      ),
    );
  }
}
