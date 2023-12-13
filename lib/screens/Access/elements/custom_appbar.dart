import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TabController tabController;
  Size get preferredSize => Size.fromHeight(56.0);
  const CustomAppBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  double progressValue = 0.0;
  
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(updateProgress);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(updateProgress);
    super.dispose();
  }

  void updateProgress() {
    setState(() {
      progressValue = (widget.tabController.index + 1) * 0.1666667;
    });
  }



  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
               Color(0xffFF4B1F),
        Color(0xffFF4B1F),
              ]),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: LinearProgressIndicator(
          value: progressValue,
          backgroundColor: Color.fromRGBO(222, 160, 115, 0.5),
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromRGBO(52, 48, 44, 0.8)),
        ),
      ),
    );
  }


}
