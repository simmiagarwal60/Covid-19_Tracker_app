import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:trackerapp/screens/world_stats.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldStats())));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(30)),
                // ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    //BorderRadius.all(Radius.circular(30)),
                    child: Image(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover,)),
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                    angle: _controller.value * 2.0 *math.pi,
                child: child,);
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            const Align(
              alignment: Alignment.center,
              child: Text("Covid-19\nTracker App", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
