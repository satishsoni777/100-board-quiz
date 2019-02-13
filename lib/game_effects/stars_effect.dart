import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

const SPEED = 200.0;
const CRATE_SIZE = 100.0;

class StarsEffect extends BaseGame {
  double creationTimer = 0.0;
  Size dimensions;
  List<Stars> stars = [];
  Image image;
  double i = 0;
  double lifeTime = 0.0;
  StarsEffect(this.dimensions) {
    i = this.dimensions.height;
    _dimension = this.dimensions;
    stars.add(crate(dimensions));
    print('height $i');
    Flame.images.load('crate.png').then((i) {
      image = i;
      print('image :: $i');
    });
  }
  Stars crate(Size size) {
    Stars stars = Stars();
    return stars;
  }

  Offset offsetEnd = Offset(200, 200);
  Offset offsetStart = Offset(240.0, 240);

  Size _dimension = Size(0.0, 0.0);
  @override
  set size(Size _size) {
    print('size $_size');
    // TODO: implement size

    super.size = _size;
  }

  @override
  void render(Canvas canvas) {
    canvas.translate(_dimension.width / 4, i);
    canvas.save();
    var paint = new Paint()..color = new Color(0xFFFF0000);
    if (image != null) {
      Rect src = new Rect.fromLTWH(
          0, 0, image.width.toDouble(), image.height.toDouble());
      Rect dst = new Rect.fromLTWH(0, 0, CRATE_SIZE, CRATE_SIZE);
      canvas.drawImageRect(image, src, dst, paint);
    }
    canvas.restore();
  }

  double initial_velocity = SPEED;
  bool down = true;
  @override
  void update(double t) {
    print(t);
    lifeTime += t;
    // // dimensions = Size(_dimension.width / 4, i);
    // if (i <= dimensions.height / 2 && t >= .01) {
    //   i = i + 10;
    // }

    i = i - initial_velocity * t;
    initial_velocity = (i - 9.8) / 2;
    if (i <= dimensions.height / 2) {
      initial_velocity = -300;
      i = dimensions.height / 2;
    }
  }
}

class Stars extends SpriteComponent {
  Stars() : super.square(128, 'crate.png');
  double lifeTime = 0.0;
}

class StarExpolsion extends PositionComponent {
  static const TIME = 0.75;
  double lifeTime = 0.0;
  List<Image> images = [];
  static final Paint paint = new Paint()..color = new Color(0xffffffff);
  void fetch() async {
    for (int i = 0; i <= 6; i++) {
      images.add(await Flame.images.load('explosion-' + i.toString() + '.png'));
    }
    print(images);
  }

  @override
  void render(Canvas c) {
    print('object');
    c.translate(x - CRATE_SIZE, y - CRATE_SIZE / 2);
    int i = (6 * this.lifeTime / TIME).round();
    if (images.length > i && images[i] != null) {
      Image image = images[i];
      Rect src = new Rect.fromLTWH(
          0.0, 0.0, image.width.toDouble(), image.height.toDouble());
      Rect dst = new Rect.fromLTWH(0.0, 0.0, CRATE_SIZE, CRATE_SIZE);
      c.drawImageRect(image, src, dst, paint);
    }
  }

  @override
  void update(double t) {
    this.lifeTime += t;
  }
}
