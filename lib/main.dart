import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // remove the debug mode
        debugShowCheckedModeBanner: false,
        title: 'Flip Animation',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State with SingleTickerProviderStateMixin {
  //create the animation controller
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    // call the animation controller at the run time
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flip Animation'),
      ), // app bar
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // Horizontal Flipping
              Transform( // transform it makes transform widgets
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..rotateY(pi * _animation.value),
                child: Card(
                  child: _animation.value <= 0.5
                      ? Container(
                      color: Colors.deepOrange,
                      width: 220,
                      height: 180,
                      child: const Center(
                          child: Text(
                            '?',
                            style: TextStyle(fontSize: 100, color: Colors.white),
                          )))
                      : Container(
                      width: 220,
                      height: 180,
                      color: Colors.grey,
                      child: Image.asset(
                        'assets/Images/dog2.jpg',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              // Vertical Flipping
              const SizedBox( // to make space between them
                height: 30,
              ),
              Transform( // the same transform above widget
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..rotateX(pi * _animation.value),
                child: Card(
                  child: _animation.value <= 0.5
                      ? Container(
                      color: Colors.deepPurple,
                      width: 220,
                      height: 180,
                      child: const Center(
                          child: Text(
                            '??',
                            style: TextStyle(fontSize: 100, color: Colors.white),
                          )))
                      : Container(
                      width: 220,
                      height: 180,
                      color: Colors.grey,
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Image.asset(
                          'assets/Images/dog3.jpg',
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_status == AnimationStatus.dismissed) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  },
                  child: const Text('Open the Card'))
            ],
          ),
        ),
      ),
    );
  }
}