import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_game/components/audio_manager.dart';
import 'package:flame_game/my_game.dart';
import 'package:flame_game/utils/assets.dart';

class ShootButton extends SpriteComponent
    with HasGameReference<MyGame>, TapCallbacks {
  ShootButton()
    : super(size: Vector2.all(80), anchor: Anchor.bottomRight, priority: 10);

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite(Assets.assetsImagesShootButton);

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    game.audioManager.playSound("laser");


    game.player.startShooting();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    game.player.stopShooting();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    game.player.stopShooting();
  }
}
