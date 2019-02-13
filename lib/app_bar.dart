import 'package:flutter/material.dart';

class AppBarDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      color: Colors.grey[800],
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.backspace, size: 20),
                onPressed: () {},
                color: Colors.yellow,
              ),
              Icon(Icons.arrow_right),
              Container(
                padding: EdgeInsets.only(left: 4, right: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black54,
                    border: Border.all(color: Colors.black26)),
                child: Text(
                  'Free choice',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      wordSpacing: 2.0,
                      textBaseline: TextBaseline.alphabetic,
                      fontFamily: 'arial',
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
              ),
              Icon(
                Icons.arrow_right,
              ),
              Container(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '100 Board Quiz',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: new LayoutBuilder(
                  builder: (context, constraint) {
                    return Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          size: constraint.maxHeight * .50,
                        ),
                        Icon(
                          Icons.star,
                          size: constraint.maxHeight * .50,
                        ),
                        Icon(
                          Icons.star,
                          size: constraint.maxHeight * .50,
                        ),
                        Icon(
                          Icons.star,
                          size: constraint.maxHeight * .50,
                        ),
                        Icon(
                          Icons.star,
                          size: constraint.maxHeight * .50,
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
          InkWell(
              onLongPress: () {},
              splashColor: Colors.white,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    height: constraint.maxHeight * .8,
                    width: constraint.maxHeight * .8,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black),
                        gradient: RadialGradient(
                            center: AlignmentDirectional.center,
                            colors: [Colors.red[600], Colors.red]),
                        borderRadius:
                            BorderRadius.circular(constraint.maxHeight / 2)),
                    child: Container(
                      height: constraint.maxHeight / 2,
                      width: constraint.maxHeight / 2,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                              colors: [Colors.red[600], Colors.redAccent]),
                          borderRadius:
                              BorderRadius.circular(constraint.maxHeight)),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
