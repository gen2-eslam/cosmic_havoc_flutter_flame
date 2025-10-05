import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_game/my_game.dart';
import 'package:flame_game/utils/assets.dart';
import 'package:flutter/cupertino.dart';

enum PickupType { bomb, laser, shield }

class Pickup extends SpriteComponent with HasGameReference<MyGame> {
  final PickupType pickupType;

  Pickup({required this.pickupType, required super.position})
    : super(size: Vector2.all(100), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite(_getSprite());

    add(CircleHitbox());
    final ScaleEffect pulseEffect = ScaleEffect.to(
      Vector2.all(0.9),
      EffectController(
        duration: 0.6,
        alternate: true,
        infinite: true,
        curve: Curves.easeInOut,
      ),
    );
    add(pulseEffect);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 300 * dt;

    if (position.y > game.size.y + size.y / 2) {
      removeFromParent();
    }
  }

  String _getSprite() {
    switch (pickupType) {
      case PickupType.bomb:
        return Assets.assetsImagesBombPickup;
      case PickupType.laser:
        return Assets.assetsImagesLaserPickup;
      case PickupType.shield:
        return Assets.assetsImagesShieldPickup;
    }
  }
}
