import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  late AnimationController _animationControllerBlue;
  late AnimationController _animationControllerYellow;

  late Animation<AlignmentGeometry> blueBallAlign;
  late Animation<AlignmentGeometry> yellowBallAlign;

  @override
  void initState() {
    _animationControllerBlue = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 4));

    _animationControllerYellow = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 4));

    blueBallAlign = Tween<AlignmentGeometry>(
            begin: Alignment.topCenter, end: Alignment.bottomCenter)
        .animate(_animationControllerBlue);
    yellowBallAlign = Tween<AlignmentGeometry>(
            begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationControllerYellow, curve: Curves.easeInOutCirc));

    _animationControllerBlue.addStatusListener((status) {
      if (_animationControllerBlue.status == AnimationStatus.dismissed &&
          _animationControllerYellow.status == AnimationStatus.completed) {
        _animationControllerYellow.reverse();
      }
    });
    _animationControllerBlue.addStatusListener((status) {
      if (_animationControllerBlue.status == AnimationStatus.completed &&
          _animationControllerYellow.status == AnimationStatus.dismissed) {
        _animationControllerYellow.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "TransitionFoo Widgtes",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            stackWidget(),
            buttonsWidgets(),
          ],
        ),
      ),
    );
  }

  Widget buttonsWidgets() {
    return Wrap(
      children: [
        ElevatedButton(
            onPressed: () => _animationControllerBlue.forward(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text("Start")),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: () => _animationControllerBlue.reverse(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text("Reverse")),
      ],
    );
  }

  Expanded stackWidget() {
    return Expanded(
      child: Stack(
        children: [
          AlignTransition(
            alignment: blueBallAlign,
            child: const CircleAvatar(backgroundColor: Colors.blue, radius: 25),
          ),
          AlignTransition(
            alignment: yellowBallAlign,
            child:
                const CircleAvatar(backgroundColor: Colors.yellow, radius: 25),
          )
        ],
      ),
    );
  }
}
