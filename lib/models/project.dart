import 'package:equatable/equatable.dart';
import 'package:merlin/merlin.dart';

class Project extends Equatable {
  const Project({
    required this.path,
    required this.gameData,
  });

  final String path;
  final MerlinGameData gameData;

  @override
  List<Object?> get props => [path, gameData];
}
