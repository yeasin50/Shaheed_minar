import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:shaheedMinar/size.dart';

class RiveMinar extends StatefulWidget {
  @override
  _RiveMinarState createState() => _RiveMinarState();
}

class _RiveMinarState extends State<RiveMinar>
    with SingleTickerProviderStateMixin {
  final SimpleAnimation animStart = SimpleAnimation("start"),
      animPlay = SimpleAnimation("play"),
      animIdle = SimpleAnimation("idle");

  ///` animation`

  //looping animation
  runningAnim() {
    setState(() {
      _riveArtboard.artboard.removeController(animIdle);
      _riveArtboard.artboard.removeController(animStart);
      _riveArtboard.artboard.addController(animPlay);
    });
  }

  /// stop is the same, we can also ignore this animation
  idleAnim() {
    setState(() {
      _riveArtboard.artboard.removeController(animPlay);
      _riveArtboard.artboard.removeController(animStart);
      _riveArtboard.artboard.addController(animIdle);
    });
  }

  Artboard _riveArtboard;
  RiveAnimationController controller;

  @override
  void initState() {
    super.initState();
    rootBundle
        .load("assets/rives/shahed_minar(start_play_idle).riv")
        .then((data) async {
      final file = RiveFile();
      if (file.import(data)) {
        setState(() {
          _riveArtboard = file.mainArtboard..addController(animStart);
        });
      }
    });

    // // log("Importing rive....."); //
    // Timer(Duration(milliseconds: 2900), () {
    //   //switch animation
    //   log("timeout");
    //   runningAnim();
    // });

    /// While finish the startUp animation, This will play the cycle animation (play)
    Timer(Duration(milliseconds: 400), () {
      animStart.isActiveChanged.addListener(() {
        if (animPlay.isActive == false) {
          log("StartUp anime ended ✌");
          SchedulerBinding.instance.addPostFrameCallback((_) {
            runningAnim();
          });
          ///`How can i delete this widget instance after anime completed`
          /// should i call outside of this widget then how 
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print("${SizeConfig.screenHeight}  ${SizeConfig.screenWidth}");
    return _riveArtboard == null
        ? SizedBox()
        : Container(
            height: getProportionateScreenHeight(400),
            child: Stack(children: <Widget>[
              Center(
                child: Container(
                  // color: Colors.green,
                  width: getProportionateScreenWidth(390),
                  height: getProportionateScreenHeight(350),
                  child: Rive(
                    fit: BoxFit.cover,
                    artboard: _riveArtboard,
                  ),
                ),
              ),

              //Play button on center (red circle)
              Positioned(
                  left: getProportionateScreenWidth(155),
                  top: getProportionateScreenHeight(90),
                  child: Container(
                    // color: Colors.blue,
                    width: getProportionateScreenWidth(110),
                    height: getProportionateScreenHeight(150),
                    child: InkWell(
                      // child: Text("play"),
                      onTap: runningAnim,
                    ),
                  )),

              Positioned(
                left: getProportionateScreenWidth(10),
                top: getProportionateScreenHeight(150),
                child: Container(
                  // color: Colors.green,
                  width: getProportionateScreenWidth(110),
                  height: getProportionateScreenHeight(150),
                  child: InkWell(
                    // child: Text("idle Anime"),
                    onTap: idleAnim,
                  ),
                ),
              ),

              Positioned(
                right: getProportionateScreenWidth(10),
                top: getProportionateScreenHeight(150),
                child: Container(
                  // color: Colors.green,
                  width: getProportionateScreenWidth(110),
                  height: getProportionateScreenHeight(150),
                  child: InkWell(
                    // child: Text("Idle Poss Anime"),
                    onTap: idleAnim,
                  ),
                ),
              ),
            ]),
          );
  }
}
