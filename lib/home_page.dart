import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gamedemo/100_grid.dart';
import 'package:gamedemo/app_bar.dart';
import 'package:gamedemo/game_effects/stars_effect.dart';
import 'dart:ui';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Paint paint = Paint();
  AudioPlayer _audioPlayer = new AudioPlayer();
  @override
  void initState() {
    super.initState();
    paint.color = Colors.red;
    paint.colorFilter = ColorFilter.mode(Colors.red, BlendMode.color);
    _play();
    _initState();
  }

  _play() async {
    // Flame.audio.play('Funny.mp3');
    // await _audioPlayer.play('audio/Funny.mp3', isLocal: false);
    _audioPlayer.completionHandler = () {};
  }

  var dimensions;
  BaseGame game;
  void _initState() async {
    dimensions = await Flame.util.initialDimensions();
    game = StarsEffect(dimensions);
    print('dimesoins:: $dimensions');
  }

  Widget _buildEffects() {
    return game.widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(
      builder: (context, ornt) {
        return ornt == Orientation.landscape
            ? Column(
                children: <Widget>[
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .087,
                      child: AppBarDesign()),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .913,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/background.jpg',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .913,
                        ),
                        Grid100(),
                        // _buildEffects()
                      ],
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: 30,
                width: 30,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
              );
      },
    ));
  }
}
