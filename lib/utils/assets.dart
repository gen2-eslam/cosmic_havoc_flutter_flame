// ignore_for_file: prefer_single_quotes
abstract class Assets {
  /// Assets for assetsAudioClick
  /// click.ogg
  static const String assetsAudioClick = "click.ogg";

  /// Assets for assetsAudioCollect
  /// collect.ogg
  static const String assetsAudioCollect = "collect.ogg";

  /// Assets for assetsAudioExplode1
  /// explode1.ogg
  static const String assetsAudioExplode1 = "explode1.ogg";

  /// Assets for assetsAudioExplode2
  /// explode2.ogg
  static const String assetsAudioExplode2 = "explode2.ogg";

  /// Assets for assetsAudioFire
  /// fire.ogg
  static const String assetsAudioFire = "fire.ogg";

  /// Assets for assetsAudioHit
  /// hit.ogg
  static const String assetsAudioHit = "hit.ogg";

  /// Assets for assetsAudioLaser
  /// laser.ogg
  static const String assetsAudioLaser = "laser.ogg";

  /// Assets for assetsAudioMusic
  /// music.ogg
  static const String assetsAudioMusic = "music.ogg";

  /// Assets for assetsAudioStart
  /// start.ogg
  static const String assetsAudioStart = "start.ogg";

  /// Assets for assetsImagesArrowButton
  /// arrow_button.png
  static const String assetsImagesArrowButton = "arrow_button.png";

  /// Assets for assetsImagesAsteroid1
  /// asteroid1.png
  static const String assetsImagesAsteroid1 = "asteroid1.png";

  /// Assets for assetsImagesAsteroid2
  /// asteroid2.png
  static const String assetsImagesAsteroid2 = "asteroid2.png";

  /// Assets for assetsImagesAsteroid3
  /// asteroid3.png
  static const String assetsImagesAsteroid3 = "asteroid3.png";

  /// Assets for assetsImagesAudioButton
  /// audio_button.png
  static const String assetsImagesAudioButton = "audio_button.png";

  /// Assets for assetsImagesBomb
  /// bomb.png
  static const String assetsImagesBomb = "bomb.png";

  /// Assets for assetsImagesBombPickup
  /// bomb_pickup.png
  static const String assetsImagesBombPickup = "bomb_pickup.png";

  /// Assets for assetsImagesExitButton
  /// exit_button.png
  static const String assetsImagesExitButton = "exit_button.png";

  /// Assets for assetsImagesJoystickBackground
  /// joystick_background.png
  static const String assetsImagesJoystickBackground =
      "joystick_background.png";

  /// Assets for assetsImagesJoystickKnob
  /// joystick_knob.png
  static const String assetsImagesJoystickKnob = "joystick_knob.png";

  /// Assets for assetsImagesLaser
  /// laser.png
  static const String assetsImagesLaser = "laser.png";

  /// Assets for assetsImagesLaserPickup
  /// laser_pickup.png
  static const String assetsImagesLaserPickup = "laser_pickup.png";

  /// Assets for assetsImagesPlayerBlueOff
  /// player_blue_off.png
  static const String assetsImagesPlayerBlueOff = "player_blue_off.png";

  /// Assets for assetsImagesPlayerBlueOn0
  /// player_blue_on0.png
  static const String assetsImagesPlayerBlueOn0 = "player_blue_on0.png";

  /// Assets for assetsImagesPlayerBlueOn1
  /// player_blue_on1.png
  static const String assetsImagesPlayerBlueOn1 = "player_blue_on1.png";

  /// Assets for assetsImagesPlayerGreenOff
  /// player_green_off.png
  static const String assetsImagesPlayerGreenOff = "player_green_off.png";

  /// Assets for assetsImagesPlayerGreenOn0
  /// player_green_on0.png
  static const String assetsImagesPlayerGreenOn0 = "player_green_on0.png";

  /// Assets for assetsImagesPlayerGreenOn1
  /// player_green_on1.png
  static const String assetsImagesPlayerGreenOn1 = "player_green_on1.png";

  /// Assets for assetsImagesPlayerPurpleOff
  /// player_purple_off.png
  static const String assetsImagesPlayerPurpleOff = "player_purple_off.png";

  /// Assets for assetsImagesPlayerPurpleOn0
  /// player_purple_on0.png
  static const String assetsImagesPlayerPurpleOn0 = "player_purple_on0.png";

  /// Assets for assetsImagesPlayerPurpleOn1
  /// player_purple_on1.png
  static const String assetsImagesPlayerPurpleOn1 = "player_purple_on1.png";

  /// Assets for assetsImagesPlayerRedOff
  /// player_red_off.png
  static const String assetsImagesPlayerRedOff = "player_red_off.png";

  /// Assets for assetsImagesPlayerRedOn0
  /// player_red_on0.png
  static const String assetsImagesPlayerRedOn0 = "player_red_on0.png";

  /// Assets for assetsImagesPlayerRedOn1
  /// player_red_on1.png
  static const String assetsImagesPlayerRedOn1 = "player_red_on1.png";

  /// Assets for assetsImagesShield
  /// shield.png
  static const String assetsImagesShield = "shield.png";

  /// Assets for assetsImagesShieldPickup
  /// shield_pickup.png
  static const String assetsImagesShieldPickup = "shield_pickup.png";

  /// Assets for assetsImagesShootButton
  /// shoot_button.png
  static const String assetsImagesShootButton = "shoot_button.png";

  /// Assets for assetsImagesStartButton
  /// start_button.png
  static const String assetsImagesStartButton = "start_button.png";

  /// Assets for assetsImagesTitle
  /// title.png
  static const String assetsImagesTitle = "title.png";
  static (String color, String index, String type) selectPlayer(String color) {
    return (
      "player_${color}_on0.png",
      "player_${color}_on1.png",
      "player_${color}_off.png",
    );
  }
}
