import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const widthAndHeight = 100.00;

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );
    
    _animation = Tween<double>(
      begin: 0,
      end: pi / 2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    _xController
    ..reset()
    ..forward();

    _yController
      ..reset()
      ..forward();

    _zController
      ..reset()
      ..forward();

    return Scaffold(
     body: SafeArea(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          SizedBox(
            height: widthAndHeight,
            width: double.infinity,
          ),
           AnimatedBuilder(
            animation: Listenable.merge([
              _xController,
              _yController,
              _zController,
            ]),
            builder: (context, child){
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(0)..rotateX(0)..rotateZ(0),
                child: Stack(
                children: [
                  Container(color: Colors.red,
                  width: widthAndHeight,
                  height: widthAndHeight,)
                ],
                ),
              );
            },
            
           ),
         ],
       ),
     ),
    
    );
  }
}
