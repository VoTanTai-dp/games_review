import 'package:flutter/material.dart';

import '../../models/game.dart';
import 'game_detail_screen.dart';

class GameGridTile extends StatelessWidget {
  const GameGridTile(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GameGridFooter(game: game),
        child: GestureDetector(
          onTap: () => {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return GameDetailScreen(game);
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            ),
          },
          child: Image.network(
            game.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class GameGridFooter extends StatelessWidget {
  const GameGridFooter({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black87,
      title: Text(
        game.name,
        textAlign: TextAlign.center,
      ),
    );
  }
}
