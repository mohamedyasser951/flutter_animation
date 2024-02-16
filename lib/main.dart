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

  late Animation<AlignmentGeometry> blueBallAlign;
  late Animation<AlignmentGeometry> yellowBallAlign;

  @override
  void initState() {
    _animationControllerBlue = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 4));

    blueBallAlign = Tween<AlignmentGeometry>(
            begin: Alignment.topCenter, end: Alignment.bottomCenter)
        .animate(_animationControllerBlue);

    super.initState();
  }

  @override
  void dispose() {
    _animationControllerBlue.dispose();
    super.dispose();
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

  void statusListenerFunction(AnimationStatus animationStatus) {
    print("Animation staus $animationStatus ===================");
  }

  void listnerFunction() {
    print(
        "Animation Value ${_animationControllerBlue.value}=====================");
  }

  Widget buttonsWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              _animationControllerBlue.value == 0
                  ? _animationControllerBlue.forward()
                  : _animationControllerBlue.reverse();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text("Start")),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ElevatedButton(
                onPressed: () {
                  _animationControllerBlue
                      .addStatusListener(statusListenerFunction);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Add Status Listener")),
            ElevatedButton(
                onPressed: () {
                  _animationControllerBlue
                      .removeStatusListener(statusListenerFunction);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Remove Status Listener")),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ElevatedButton(
                onPressed: () {
                  blueBallAlign.addListener(listnerFunction);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Add Value Listener")),
            ElevatedButton(
                onPressed: () {
                  blueBallAlign.removeListener(listnerFunction);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Remove Value Listener")),
          ],
        ),
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
        ],
      ),
    );
  }
}
