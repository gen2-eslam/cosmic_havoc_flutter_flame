import 'dart:async';
import 'dart:math';
import 'package:flame/effects.dart';
import 'package:flame_game/components/audio_manager.dart';
import 'package:flame_game/components/pickup.dart';
import 'package:flame_game/components/star.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_game/components/asteroid.dart';
import 'package:flame_game/components/player.dart';
import 'package:flame_game/components/shoot_button.dart';
import 'package:flame_game/utils/assets.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late Player player;
  late SpawnComponent _asteroid;
  late JoystickComponent joystick;
  late ShootButton _shootButton;
  late SpawnComponent _pickupSpawner;
  final Random _random = Random();
  int _score = 0;
  late TextComponent _scoreDisplay;
  final List<String> playerColors = ["blue", "red", "green", "purple"];
  int playerColorIndex = 0;
  late final AudioManager audioManager;
  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    _createStarts();
    audioManager = AudioManager();
    await add(audioManager);
    audioManager.playMusic();
    // startGame();
    return super.onLoad();
  }

  void startGame() async {
    await _createJoystick();
    await _createPlayer();
    _createAsteroidsSpawner();
    _createPickupSpawner();

    _createShootButton();
    _createScoreDisplay();
  }

  Future<void> _createPlayer() async {
    player =
        Player()
          ..anchor = Anchor.center
          ..position = Vector2(size.x / 2, size.y * 0.8);

    add(player);
  }

  Future<void> _createJoystick() async {
    joystick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(
        sprite: await loadSprite(Assets.assetsImagesJoystickKnob),
        size: Vector2.all(50),
      ),
      background: SpriteComponent(
        sprite: await loadSprite(Assets.assetsImagesJoystickBackground),
        size: Vector2.all(100),
      ),
      anchor: Anchor.bottomLeft,
      position: Vector2(20, size.y - 20),
    );
    add(joystick);
  }

  void _createShootButton() {
    _shootButton = ShootButton()..position = Vector2(size.x - 20, size.y - 20);
    add(_shootButton);
  }

  void _createAsteroidsSpawner() {
    _asteroid = SpawnComponent.periodRange(
      factory: (index) => Asteroid(position: _generateStartPosition()),
      minPeriod: 0.7,
      maxPeriod: 1.2,

      selfPositioning: true,
    );
    add(_asteroid);
  }

  void _createPickupSpawner() {
    _pickupSpawner = SpawnComponent.periodRange(
      factory:
          (index) => Pickup(
            position: _generateStartPosition(),
            pickupType:
                PickupType.values[_random.nextInt(PickupType.values.length)],
          ),
      minPeriod: 5,
      maxPeriod: 10,

      selfPositioning: true,
    );
    add(_pickupSpawner);
  }

  Vector2 _generateStartPosition() {
    final double x = 10 + _random.nextDouble() * (size.x - 10 * 2);
    final double y = -200;
    return Vector2(x, y);
  }

  void _createScoreDisplay() {
    _score = 0;
    _scoreDisplay = TextComponent(
      text: "Score: $_score",
      anchor: Anchor.topCenter,
      position: Vector2(size.x / 2, 20),
      priority: 10,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 2),
          ],
        ),
      ),
    );
    add(_scoreDisplay);
  }

  void incrmenetScore(int amount) {
    _score += amount;
    _scoreDisplay.text = "$_score";
    final ScaleEffect popEffect = ScaleEffect.by(
      Vector2(1.1, 1.1),
      EffectController(duration: 0.3, alternate: true, curve: Curves.easeInOut),
    );
    _scoreDisplay.add(popEffect);
  }

  void _createStarts() {
    for (int i = 0; i < 50; i++) {
      add(Star()..priority = -10);
    }
  }

  void playerDied() {
    overlays.add("GameOver");
    pauseEngine();
  }

  void restartGame() {
    children.whereType<PositionComponent>().forEach((componant) {
      if (componant is Asteroid || componant is Pickup) {
        remove(componant);
      }
    });
    _asteroid.timer.start();
    _pickupSpawner.timer.start();
    _score = 0;
    _scoreDisplay.text = "0";
    _createPlayer();
    resumeEngine();
  }

  void quitGame() {
    children.whereType<PositionComponent>().forEach((componant) {
      if (componant is! Star) {
        remove(componant);
      }
    });
    remove(_asteroid);
    remove(_pickupSpawner);
    overlays.add("Title");
    resumeEngine();
  }
}
