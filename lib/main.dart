import 'package:flame/game.dart';
import 'package:flame_game/my_game.dart';
import 'package:flame_game/overlays/game_over_overlay.dart';
import 'package:flame_game/overlays/title_overlay.dart';
import 'package:flutter/material.dart';

void main() {
  final MyGame game = MyGame();
  runApp(
    GameWidget(
      game: game,
      
      overlayBuilderMap: {
        "GameOver":
            (BuildContext context, MyGame game) => GameOverOverlay(game: game),
        "Title":
            (BuildContext context, MyGame game) => TitleOverlay(game: game),
      },
      initialActiveOverlays: const ['Title'],
    ),
  );
}
