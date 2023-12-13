import 'package:flutter/material.dart';
import 'package:loginbloc/screens/Access/Interests.dart';
import 'package:loginbloc/screens/Access/elements/custom_appbar.dart';
import 'package:loginbloc/screens/Access/signup_email.dart';
import 'package:loginbloc/screens/Access/signup_username.dart';
import '../signup_age.dart';

class OnboardingScreen extends StatelessWidget {

  static const List<Tab> tabs = <Tab>[
   // Tab(text: 'Start'),
    Tab(text: 'Email'),
  //  Tab(text: 'Demographics'),
    Tab(text: 'Pictures'),
    Tab(text: 'Age'),
    Tab(text: 'Location')
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;

        return Scaffold(
          appBar: CustomAppBar(
            tabController: tabController,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                     Color(0xffFF4B1F),
          Color.fromARGB(255, 189, 47, 11),
          Color.fromARGB(255, 50, 4, 4),
                  ]),
            ),
            child: TabBarView(
              children: [
              // Start(tabController: tabController),
                EmailSignupScreen(tabController: tabController),
                UsernameScreen(tabController: tabController),
                AgeSignupScreen(tabController: tabController),
                InterestsScreen(tabController: tabController),
             //   LevelsScreen(tabController: tabController, selectedInterests: [],),
              ],
            ),
          ),
        );
      }),
    );
  }
}
