import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_game/components/audio_manager.dart';
import 'package:flame_game/components/explosion.dart';
import 'package:flame_game/my_game.dart';
import 'package:flame_game/utils/assets.dart';
import 'package:flutter/material.dart';

class Asteroid extends SpriteComponent with HasGameReference<MyGame> {
  final Random _random = Random();
  static const double _maxSize = 120;
  final double _maxHealth = 3;
  late double _health;
  late Vector2 _velocity;
  final Vector2 _originalVelocity = Vector2.zero();
  late double _spinSpeed;
  bool _isKnockback = false;
  final List<String> _astroidImages = [
    Assets.assetsImagesAsteroid1,
    Assets.assetsImagesAsteroid2,
    Assets.assetsImagesAsteroid3,
  ];

  Asteroid({required super.position, double size = _maxSize})
    : super(size: Vector2.all(size), anchor: Anchor.center, priority: -1) {
    _velocity = _generateVelocity();
    _originalVelocity.setFrom(_velocity);
    _spinSpeed = _random.nextDouble() * 1.5 - 0.75;
    _health = size / _maxSize * _maxHealth;
    add(CircleHitbox(collisionType: CollisionType.passive));
  }

  @override
  Future<void> onLoad() async {
    final int imageIndex = _random.nextInt(_astroidImages.length);
    sprite = await game.loadSprite(_astroidImages[imageIndex]);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += _velocity * dt;
    angle += _spinSpeed * dt;
    _handleScreenBounds();
    super.update(dt);
  }

  Vector2 _generateVelocity() {
    final double fourceFactor = _maxSize / size.x;
    final double x = _random.nextDouble() * 150 - 60;
    final double y = 100 + _random.nextDouble() * 50;
    return Vector2(x, y) * fourceFactor;
  }

  void _handleScreenBounds() {
    if (position.y > game.size.y + size.y / 2) {
      removeFromParent();
    }
    final double screenWidth = game.size.x;
    if (position.x < -size.x / 2) {
      // removeFromParent();

      position.x = screenWidth + size.x / 2;
    } else if (position.x > screenWidth + size.x / 2) {
      // removeFromParent();

      position.x = -size.x / 2;
    }
  }

  void takeDamage() {
    game.audioManager.playSound("hit");
    _health--;

    if (_health <= 0) {
      game.incrmenetScore(2);

      removeFromParent();
      _createExplosion();
      _splitAsteroid();
    } else {
      _flashWhite();
      _applyKnockback();
    }
  }

  void _flashWhite() {
    final ColorEffect flashEffect = ColorEffect(
      const Color.fromRGBO(255, 255, 255, 1.0),
      EffectController(duration: 0.2, alternate: true, curve: Curves.easeInOut),
    );
    add(flashEffect);
  }

  void _applyKnockback() {
    if (_isKnockback) {
      return;
    }
    _isKnockback = true;
    _velocity.setZero();
    final MoveByEffect konkbackEffect = MoveByEffect(
      Vector2(0, -20),
      EffectController(duration: 0.1),
      onComplete: _resetVelocity,
    );
    add(konkbackEffect);
  }

  void _resetVelocity() {
    _velocity.setFrom(_originalVelocity);
    _isKnockback = false;
  }

  void _createExplosion() {
    final Explosion explosion = Explosion(
      position: position.clone(),
      explosionSize: size.x,
      explosionType: ExplosionType.dust,
    );
    game.add(explosion);
  }

  void _splitAsteroid() {
    if (size.x <= _maxSize / 3) return;
    for (int i = 0; i < 3; i++) {
      final Asteroid fragment = Asteroid(
        position: position.clone(),
        size: size.x - _maxSize / 3,
      );
      game.add(fragment);
    }
  }
}
