import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

import '../models/game.dart';
import 'pocketbase_client.dart';

class GamesService {
  String _getFeaturedImageUrl(PocketBase pb, RecordModel gameModel) {
    final featuredImageName = gameModel.getStringValue('featuredImage');
    return pb.files.getUrl(gameModel, featuredImageName).toString();
  }

  Future<Game?> addProduct(Game game) async {
    try {
      final pb = await getPocketbaseInstance();

      final gameModel = await pb.collection('games').create(
        body: game.toJson(),
        files: [
          http.MultipartFile.fromBytes(
            'featuredImage',
            await game.featuredImage!.readAsBytes(),
            filename: game.featuredImage!.uri.pathSegments.last,
          ),
        ],
      );

      return game.copyWith(
        id: gameModel.id,
        imageUrl: _getFeaturedImageUrl(pb, gameModel),
      );
    } catch (error) {
      return null;
    }
  }

  Future<List<Game>> fetchGames() async {
    final List<Game> games = [];

    try {
      final pb = await getPocketbaseInstance();
      final gameModels = await pb.collection('games').getFullList();

      for (final gameModel in gameModels) {
        games.add(
          Game.fromJson(
            gameModel.toJson()
              ..addAll({'imageUrl': _getFeaturedImageUrl(pb, gameModel)}),
          ),
        );
      }

      return games;
    } catch (error) {
      return games;
    }
  }

  Future<Game?> updateGame(Game game) async {
    try {
      final pb = await getPocketbaseInstance();

      final gameModel = await pb.collection('games').update(
            game.id!,
            body: game.toJson(),
            files: game.featuredImage != null
                ? [
                    http.MultipartFile.fromBytes(
                      'featuredImage',
                      await game.featuredImage!.readAsBytes(),
                      filename: game.featuredImage!.uri.pathSegments.last,
                    ),
                  ]
                : [],
          );

      return game.copyWith(
        imageUrl: game.featuredImage != null
            ? _getFeaturedImageUrl(pb, gameModel)
            : game.imageUrl,
      );
    } catch (error) {
      return null;
    }
  }

  Future<bool> deleteGame(String id) async {
    try {
      final pb = await getPocketbaseInstance();
      await pb.collection('games').delete(id);
      return true;
    } catch (error) {
      return false;
    }
  }
}
