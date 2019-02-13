import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gamedemo/draggable.dart';
import 'package:gamedemo/darg_target.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:tts/tts.dart';

class Grid100 extends StatefulWidget {
  @override
  _Grid100State createState() => new _Grid100State();
}

class _Grid100State extends State<Grid100> with SingleTickerProviderStateMixin {
  List<String> no = [];
  List<String> _shuffle = [];
  String _text = '';
  SpriteTexture texture;
  Tts tts;
  int i = 0;
  Offset offset = Offset(0.0, 0.0);
  @override
  void initState() {
    for (int i = 1; i <= 100; i++) no.add(i.toString());
    _shuffle.addAll(no);
    _shuffle.shuffle();
    print(no);
    super.initState();
  }

  void _offset(Offset o) {
    print('get offset:: $o');
    setState(() {
      offset = o;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return new SizedBox(
          height: constraint.maxHeight,
          width: constraint.maxWidth * .80,
          child: Container(
            color: Colors.blue[800],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    height: constraint.maxHeight,
                    width: constraint.maxWidth * .9,
                    color: Colors.blue[300],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 10,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4),
                          shrinkWrap: true,
                          children: no
                              .map((s) => Padding(
                                  padding: EdgeInsets.all(0),
                                  child: AnimatedButton(
                                    text: s,
                                    size: Size(constraint.maxWidth * .8 * .1,
                                        constraint.maxHeight * .8 * .1),
                                    offset: _offset,
                                  )))
                              .toList(growable: false),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AutoSizeText(
                            'Find ${_shuffle[i]}.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        DragTargetBox(
                          shuffledText: _shuffle[i],
                          offset: offset,
                        )
                      ],
                    ),
                    Positioned(
                      left: 50,
                      top: 8,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Center(
                          child: RawMaterialButton(
                            splashColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () => Tts.speak('Find ${_shuffle[i]}'),
                            child: Icon(Icons.mic),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
