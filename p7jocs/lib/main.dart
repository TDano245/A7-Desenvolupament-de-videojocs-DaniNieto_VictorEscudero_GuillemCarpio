import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

void main() {
  // Create the game first so we can start it paused and show the main menu overlay.
  final game = SpaceShooterGame();
  // Start paused so the menu is visible and the game doesn't run in the background.
  game.pauseEngine();

  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        'MainMenu': (BuildContext ctx, SpaceShooterGame g) {
          return Center(
            child: Container(
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Space Shooter',
                        style: TextStyle(color: Colors.white, fontSize: 28)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        g.overlays.remove('MainMenu');
                        g.resumeGame();
                      },
                      child: const Text('Play'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        g.overlays.add('LevelSelect');
                      },
                      child: const Text('Select Level'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        g.overlays.add('Settings');
                      },
                      child: const Text('Settings'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        'LevelSelect': (BuildContext ctx, SpaceShooterGame g) {
          return Center(
            child: Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Select Level',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: List.generate(
                      3,
                      (i) => ElevatedButton(
                        onPressed: () {
                          g.level = i + 1;
                          // Close level selector and go back to main menu
                          g.overlays.remove('LevelSelect');
                        },
                        child: Text('Level ${i + 1}'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => g.overlays.remove('LevelSelect'),
                    child: const Text('Back'),
                  ),
                ],
              ),
            ),
          );
        },
        'Settings': (BuildContext ctx, SpaceShooterGame g) {
          return Center(
            child: Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Settings',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Sound', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 12),
                      Switch(
                        value: g.soundOn,
                        onChanged: (v) {
                          g.soundOn = v;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Music', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 12),
                      Switch(
                        value: g.musicOn,
                        onChanged: (v) {
                          g.musicOn = v;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => g.overlays.remove('Settings'),
                    child: const Text('Back'),
                  ),
                ],
              ),
            ),
          );
        },
        'PauseMenu': (BuildContext ctx, SpaceShooterGame g) {
          return Center(
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Paused',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      g.overlays.remove('PauseMenu');
                      g.resumeGame();
                    },
                    child: const Text('Resume'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // go back to main menu
                      g.overlays.remove('PauseMenu');
                      // pause the engine and show main menu
                      g.pauseGame();
                      g.overlays.add('MainMenu');
                    },
                    child: const Text('Main Menu'),
                  ),
                ],
              ),
            ),
          );
        },
        'PauseButton': (BuildContext ctx, SpaceShooterGame g) {
          return SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.black54,
                  onPressed: () {
                    // show pause overlay and pause engine
                    g.overlays.add('PauseMenu');
                    g.pauseGame();
                  },
                  child: const Icon(Icons.pause),
                ),
              ),
            ),
          );
        },
      },
      // Start with the main menu overlay active
      initialActiveOverlays: const ['MainMenu'],
    ),
  );
}

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;
  // Game state exposed to overlays
  int level = 1;
  bool soundOn = true;
  bool musicOn = true;

  /// Resume the game engine and show the pause button overlay.
  void resumeGame() {
    resumeEngine();
    overlays.add('PauseButton');
  }

  /// Pause the game engine and hide the pause button overlay.
  void pauseGame() {
    pauseEngine();
    overlays.remove('PauseButton');
  }
  @override
  Color backgroundColor() => Colors.white;

  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('stars_0.png'),
        ParallaxImageData('stars_1.png'),
        ParallaxImageData('stars_2.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );
    add(parallax);

    player = Player();
    add(player);

    add(
      SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }
}

class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Player()
    : super(
        size: Vector2(100, 150),
        anchor: Anchor.center,
      );

  late final SpawnComponent _bulletSpawner;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(32, 48),
      ),
    );

    position = game.size / 2;

    _bulletSpawner = SpawnComponent(
      period: 0.2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position:
              position +
              Vector2(
                0,
                -height / 2,
              ),
        );
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }
}

class Bullet extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Bullet({
    super.position,
  }) : super(
         size: Vector2(25, 50),
         anchor: Anchor.center,
       );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(8, 16),
      ),
    );

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * -500;

    if (position.y < -height) {
      removeFromParent();
    }
  }
}

class Enemy extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  Enemy({
    super.position,
  }) : super(
         size: Vector2.all(enemySize),
         anchor: Anchor.center,
       );

  static const enemySize = 50.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2.all(16),
      ),
    );

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
    }
  }
}

class Explosion extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Explosion({
    super.position,
  }) : super(
         size: Vector2.all(150),
         anchor: Anchor.center,
         removeOnFinish: true,
       );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'explosion.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}