import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flame_game/components/audio_manager.dart';
import 'package:flame_game/my_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum ExplosionType { dust, smoke, fire }

class Explosion extends PositionComponent with HasGameReference<MyGame> {
  final ExplosionType explosionType;
  final double explosionSize;
  final Random _random = Random();

  Explosion({
    required super.position,
    required this.explosionType,
    required this.explosionSize,
  });

  @override
  FutureOr<void> onLoad() {
    final int rand = 1 + _random.nextInt(2);
    game.audioManager.playSound("explode$rand");
    _createFlash();
    _createParticales();
    add(RemoveEffect(delay: 1.0));

    return super.onLoad();
  }

  void _createFlash() {
    final CircleComponent flash = CircleComponent(
      radius: explosionSize * 0.6,
      paint: Paint()..color = const Color.fromRGBO(255, 255, 255, 1.0),
      anchor: Anchor.center,
    );
    final OpacityEffect fadeOutEffect = OpacityEffect.fadeOut(
      EffectController(duration: 0.3),
    );
    flash.add(fadeOutEffect);
    add(flash);
  }

  List<Color> _generateColors() {
    switch (explosionType) {
      case ExplosionType.dust:
        return [
          const Color(0xFF5A4632),
          const Color(0xFF6B543D),
          const Color(0xFF8A6E50),
        ];
      case ExplosionType.smoke:
        return [
          const Color(0xFF404040),
          const Color(0xFF606060),
          const Color(0xFF808080),
        ];
      case ExplosionType.fire:
        return [
          const Color(0xFFFFD700),
          const Color(0xFFFFA500),
          const Color(0xFFFFC107),
        ];
    }
  }

  void _createParticales() {
    final List<Color> colors = _generateColors();
    int count = 8 + _random.nextInt(5);
    final ParticleSystemComponent particleSystem = ParticleSystemComponent(
      particle: Particle.generate(
        count: count,
        generator: (index) {
          return _movingParticaleGenerator(colors);
        },
      ),
    );
    add(particleSystem);
  }

  MovingParticle _movingParticaleGenerator(List<Color> colors) {
    double radius = explosionSize * (0.1 + _random.nextDouble() * 0.05);
    double lifrespan = 0.5 + _random.nextDouble() * 0.5;
    final Paint paint =
        Paint()
          ..color = colors[_random.nextInt(colors.length)].withValues(
            alpha: 0.4 + _random.nextDouble() * 0.4,
          );
    return MovingParticle(
      child: CircleParticle(radius: radius, paint: paint),
      lifespan: lifrespan,
      to: Vector2(
        (_random.nextDouble() - 0.5) * explosionSize * 2,
        (_random.nextDouble() - 0.5) * explosionSize * 2,
      ),
    );
  }
}
