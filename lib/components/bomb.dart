import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_game/components/asteroid.dart';
import 'package:flame_game/my_game.dart';
import 'package:flame_game/utils/assets.dart';
import 'package:flutter/animation.dart';

class Bomb extends SpriteComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  Bomb({required super.position})
    : super(size: Vector2.all(1), anchor: Anchor.center, priority: -1);

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite(Assets.assetsImagesBomb);
    add(CircleHitbox(isSolid: true));
    game.audioManager.playSound("fire");
    final SequenceEffect sequenceEffect = SequenceEffect([
      SizeEffect.to(
        Vector2.all(800),
        EffectController(duration: 1.0, curve: Curves.easeInOut),
      ),
      OpacityEffect.fadeOut(EffectController(duration: 0.5)),
      RemoveEffect(
    
      ),
    ]);
    add(sequenceEffect);

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
