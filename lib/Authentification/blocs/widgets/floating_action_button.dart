import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';

class FloatingActionButton extends StatefulWidget {
  const FloatingActionButton({super.key});

  @override
  State<FloatingActionButton> createState() => _FloatingActionButtonState();
}

class _FloatingActionButtonState extends State<FloatingActionButton>  with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
         
        body: Container(
          height: double.infinity,
          color: Colors.yellowAccent[100],
        ),
        floatingActionButton: FloatingActionBubble(
          items: <Bubble>[
            Bubble(
              title: "Settings",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.settings,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController!.reverse();
              },
            ),
            Bubble(
              title: "Profile",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.people,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController!.reverse();
              },
            ),
            Bubble(
              title: "Home",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.home,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController!.reverse();
              },
            ),
          ],
          animation: _animation!,
          onPress: () => _animationController!.isCompleted
              ? _animationController!.reverse()
              : _animationController!.forward(),
          backGroundColor: Colors.blue,
          iconColor: Colors.white,
          iconData: Icons.menu,
        ));
  }
}
