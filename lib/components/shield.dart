import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_game/components/asteroid.dart';
import 'package:flame_game/my_game.dart';
import 'package:flame_game/utils/assets.dart';
import 'package:flutter/widgets.dart';

class Shield extends SpriteComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  Shield() : super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite(Assets.assetsImagesShield);
    position = game.player.size / 2;
    add(CircleHitbox());
    final ScaleEffect pulseEffect = ScaleEffect.to(
      Vector2.all(1.1),
      EffectController(
        duration: 0.6,
        alternate: true,
        infinite: true,
        curve: Curves.easeInOut,
      ),
    );
    add(pulseEffect);
    final OpacityEffect fadeOutEffect = OpacityEffect.fadeOut(
      EffectController(duration: 2.0, startDelay: 3.0),
      onComplete: () {
        removeFromParent();
        game.player.activeShield = null;
      },
    );
    add(fadeOutEffect);

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Asteroid) {
      other.takeDamage();
    }
  }
}
