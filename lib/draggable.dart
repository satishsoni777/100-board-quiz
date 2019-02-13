import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final Size size;
  final String text;
  final Function(Offset) offset;
  AnimatedButton({
    this.text,
    this.offset,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (context, constraint) {
        return Draggable(
          onDraggableCanceled: (velocity, offset) {
            print(' $offset');
          },
          data: text,
          onDragCompleted: () {
            print(('darg completed'));
          },
          onDragEnd: (DraggableDetails detail) {
            print('darg end: ${detail.offset}');
            offset(detail.offset);
          },
          childWhenDragging: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: constraint.maxHeight / 1.2,
              width: constraint.maxWidth / 1.2,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 2.0, color: Color(0xff191970))
                  ],
                  color: Color(0xff191970),
                  borderRadius: BorderRadius.circular((constraint.maxHeight))),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          feedback: Material(
            color: Colors.transparent,
            child: Container(
                child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: 79,
                  width: 79,
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Orbitron'),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          colorFilter:
                              ColorFilter.mode(Colors.blue, BlendMode.color),
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/button.jpg',
                          ))),
                ),
              ],
            )),
          ),
          child: RawMaterialButton(
            clipBehavior: Clip.hardEdge,
            fillColor: Color(0xff483d8b),
            elevation: 8,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Color(0xff191970))
                    ],
                    color: Color(0xff191970),
                    borderRadius: BorderRadius.circular((constraint.maxWidth))),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                side: BorderSide(width: 0.0, color: Colors.blue)),
          ),
        );
      },
    );
  }
}
