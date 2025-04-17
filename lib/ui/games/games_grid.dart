import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/game.dart';
import 'game_grid_tile.dart';
import 'games_manager.dart';

class GamesGrid extends StatelessWidget {
  final String selectedType;

  const GamesGrid({super.key, required this.selectedType});

  @override
  Widget build(BuildContext context) {
    final gamesManager = Provider.of<GamesManager>(context);

    List<Game> filteredGames = selectedType == 'All'
        ? gamesManager.games
        : gamesManager.games
            .where((game) => game.category == selectedType)
            .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: filteredGames.length,
      itemBuilder: (ctx, index) {
        return GameGridTile(filteredGames[index]);
      },
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}
