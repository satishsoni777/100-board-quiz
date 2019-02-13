import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:flame/flame.dart';

class DragTargetBox extends StatefulWidget {
  final String shuffledText;
  final Animation animation;
  final Offset offset;
  DragTargetBox({this.shuffledText, this.animation, this.offset});

  @override
  DragTargetBoxState createState() {
    return new DragTargetBoxState();
  }
}

class DragTargetBoxState extends State<DragTargetBox>
    with SingleTickerProviderStateMixin {
  AnimationController slideController;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> animation;
  String text = '';
  GlobalKey _keyRed = GlobalKey();
  SpriteSheet sheet;
  var image;
  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(1.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.elasticInOut,
  ));
  @override
  void initState() {
    print('initState:: ${widget.offset}');
    super.initState();
    slideController = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(slideController),
      curve: Curves.fastOutSlowIn,
    )..addListener(() {
        setState(() {});
      });
    animation = slideController.drive(_drawerDetailsTween);
    // WidgetsBinding.instance.addPostFrameCallback(_getPositions());
  }

  _getPositions() {
    print('after');
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of Red: $positionRed ");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool isTrue = false;
  @override
  void didUpdateWidget(DragTargetBox oldWidget) {
    new Future.delayed(Duration(seconds: 1), () {
      // if (widget.shuffledText == text) isTrue = true;
    });

    if (widget.shuffledText == text)
      slideController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          slideController.forward();
        } else if (status == AnimationStatus.dismissed) {
          slideController.reverse();
        }
      });
    if (widget.shuffledText == text)
      new Future.delayed(Duration(seconds: 2), () {
        slideController.stop();
      });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return new DragTarget(
      onAccept: (String str) {
        print('on accept::$str');
        text = str;
      },
      builder:
          (BuildContext context, List<String> candidateData, rejectedData) {
        print('builder: ${candidateData},$rejectedData');
        return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: widget.shuffledText == text
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[300],
                          blurRadius: 2.0,
                          // spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Colors.blue[100],
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      gradient: RadialGradient(
                          colors: [Colors.blue[600], Colors.blue[900]]))
                  : BoxDecoration(),
            ),
          ),
          Container(
              height: 86,
              width: 86,
              decoration: BoxDecoration(
                  boxShadow: widget.shuffledText == text
                      ? [BoxShadow(blurRadius: 3.0, color: Colors.white70)]
                      : [],
                  border: Border.all(
                      color: widget.shuffledText != text
                          ? Colors.blue[900]
                          : Colors.white,
                      width: 6.0),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Container(
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: widget.shuffledText == text
                        ? BoxDecoration(
                            boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.yellow[50],
                                    spreadRadius: 3.0)
                              ],
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white)
                        : BoxDecoration(),
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xff000080),
                            fontSize: 20,
                            fontFamily: 'Orbitron'),
                      ),
                    ),
                  ),
                ),
                decoration: widget.shuffledText == text
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            colorFilter: widget.shuffledText != text
                                ? ColorFilter.mode(Colors.blue, BlendMode.color)
                                : ColorFilter.mode(
                                    Colors.yellow[600], BlendMode.color),
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/button.jpg',
                            )))
                    : BoxDecoration(),
              )
              // : AnimatedContainer(
              //     transform: Matrix4.rotationZ(animation.value.direction),
              //     duration: Duration(seconds: 1),
              //     child: Container(
              //       child: Center(
              //         child: Text(
              //           text,
              //           style: TextStyle(color: Colors.white, fontSize: 20),
              //         ),
              //       ),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           image: DecorationImage(
              //               colorFilter: ColorFilter.mode(
              //                   Colors.blue, BlendMode.color),
              //               fit: BoxFit.cover,
              //               image: AssetImage(
              //                 'assets/images/button.jpg',
              //               ))),
              //     ),

              //   )
              )
        ]);
      },
    );
  }
}

class ButtonAnimation extends AnimatedWidget {
  ButtonAnimation({Key key, Animation animation, this.child})
      : super(key: key, listenable: animation);
  Widget child;
  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Transform.rotate(
      alignment: AlignmentDirectional.center,
      angle: animation.value,
      child: child,
    );
  }
}

class TextureEffect extends CustomPainter {
  TextureEffect() {}
  SpriteTexture sprit;
  Paint _paint = new Paint();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    _paint.color = Colors.red;
    _paint.blendMode = BlendMode.srcATop;
    // sprit.drawTexture(canvas, Offset(516.1, 199.6), _paint);
    canvas.drawCircle(Offset(516.1, 10.6), 200, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
