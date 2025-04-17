import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/game.dart';
import '../shared/dialog_utils.dart';
import 'edit_add_game_screen.dart';
import 'games_manager.dart';

class ManageGameListTile extends StatelessWidget {
  final Game game;

  const ManageGameListTile(this.game, {super.key});

  void _deleteGame(BuildContext context, String gameId) async {
    bool? confirm = await showConfirmDialog(
      context,
      'Are you sure you want to delete this game?',
    );

    if (!context.mounted) return;

    if (confirm == true) {
      context.read<GamesManager>().deleteGame(gameId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                game.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                game.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  EditGameButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        EditAddGameScreen.routeName,
                        arguments: game.id,
                      );
                    },
                  ),
                  DeleteGameButton(
                    onPressed: () => _deleteGame(context, game.id!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteGameButton extends StatelessWidget {
  const DeleteGameButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.delete),
      color: Theme.of(context).colorScheme.error,
    );
  }
}

class EditGameButton extends StatelessWidget {
  const EditGameButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.edit),
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
