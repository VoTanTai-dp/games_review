import 'package:flutter/foundation.dart';

import '../../models/game.dart';
import '../../services/games_service.dart';

class GamesManager with ChangeNotifier {
  final GamesService _gamesService = GamesService();
  final List<Game> _games = [];

  int get itemCount {
    return _games.length;
  }

  List<Game> get games {
    return [..._games];
  }

  Future<void> addGame(Game game) async {
    final newGame = await _gamesService.addProduct(game);
    if (newGame != null) {
      _games.add(newGame);
      notifyListeners();
    }
  }

  Future<void> updateGame(Game game) async {
    final gameIndex = _games.indexWhere((g) => g.id == game.id);
    if (gameIndex >= 0) {
      final updatedGame = await _gamesService.updateGame(game);
      if (updatedGame != null) {
        _games[gameIndex] = updatedGame;
        notifyListeners();
      }
    }
  }

  Future<void> deleteGame(String id) async {
    final gameIndex = _games.indexWhere((g) => g.id == id);
    if (gameIndex >= 0 && await _gamesService.deleteGame(id)) {
      _games.removeAt(gameIndex);
      notifyListeners();
    }
  }

  Game? findById(String id) {
    try {
      return _games.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  Future<void> fetchGames() async {
    final games = await _gamesService.fetchGames();
    if (games.isNotEmpty) {
      _games.addAll(games);
      notifyListeners();
    }
  }
}
