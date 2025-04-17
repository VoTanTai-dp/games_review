import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_add_game_screen.dart';
import 'games_manager.dart';
import 'manage_game_list_tile.dart';

class ManageGameScreen extends StatelessWidget {
  const ManageGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games Manager',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: AddGameButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditAddGameScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: GameList(),
    );
  }
}

class GameList extends StatelessWidget {
  const GameList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesManager>(
      builder: (context, gameManager, child) {
        return ListView.builder(
          itemCount: gameManager.itemCount,
          itemBuilder: (context, index) => Column(
            children: [
              ManageGameListTile(gameManager.games[index]),
            ],
          ),
        );
      },
    );
  }
}

class AddGameButton extends StatelessWidget {
  const AddGameButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.add),
    );
  }
}
