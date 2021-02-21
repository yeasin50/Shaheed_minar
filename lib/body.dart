import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shaheedMinar/size.dart';

import 'rive/shaheed_minar.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool mapVisible = true;
  var _currentOpacity = 0.0;

  //map Visiblity
  hideMap() => setState(() => mapVisible = !mapVisible);

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        _currentOpacity = 1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        //Map

        Positioned(
          top: 30,
          right: 10,
          child: InkWell(
            onTap: hideMap,
            splashColor: Colors.white10,
            child: Container(
                width: getProportionateScreenWidth(70),
                height: getProportionateScreenHeight(90),
                child: mapVisible
                    ? Image.asset(
                        "assets/images/map.png",
                        fit: BoxFit.cover,
                      )
                    : SizedBox()),
          ),
        ),
        Center(
          child: RiveMinar(),
        ),
        Positioned(
          //dont left=right=0=center
          bottom: getProportionateScreenHeight(310),
          left: getProportionateScreenWidth(82),
          child: AnimatedOpacity(
            opacity: _currentOpacity,
            duration: Duration(seconds: 2),
            child: Row(
              children: [
                buildCharContainer(context, "অ"),
                buildCharContainer(context, "ম"),
                buildCharContainer(context, "র"),
                buildCharContainer(context, "এ"),
                buildCharContainer(context, "কু"),
                buildCharContainer(context, "শে"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// অমর একুশে
  Container buildCharContainer(BuildContext context, String char) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(2)),
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(7)),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.white70,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.white,
              // offset: Offset(3,1),
            ),
          ]),
      child: Text(
        char,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline5.fontSize,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
