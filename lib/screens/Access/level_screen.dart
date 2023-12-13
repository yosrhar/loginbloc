
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/Authentification/responsive/mobileScreenLayout.dart';
import 'package:provider/provider.dart';
import '../../../Authentification/blocs/onboarding/onboarding_bloc.dart';
import '../../../Authentification/repositories/auth/auth_repository.dart';
 
import 'elements/custom_form_button.dart';

class LevelsScreen extends StatefulWidget {
  //final TabController tabController;
  final List<String> selectedInterests;

  const LevelsScreen({
    Key? key,
    // required this.tabController,
    required this.selectedInterests,
  }) : super(key: key);

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
 // Map<String, String?> selectedLevels = local.User.defaultUser().levels;
  void onLevelSelected(String interest, String? level) {
    setState(() {
      selectedLevels[interest] = level;
    });
  }

  Map<String, String?> selectedLevels = {};
  bool _isLoading = false;

  final _levelslist = [
    "Novice",
    "Advanced Beginner",
    "Intermediate",
    "Upper Intermediate",
    "Advanced",
    "Professional"
  ];
  void navigateToMobileScreenLayout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => mobileScreenLayout(),
      ),
    );
  }

  List<Widget> buildDropdownMenus() {
    List<Widget> dropdowns = [];
    for (String interest in widget.selectedInterests) {
      dropdowns.add(
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(interest),
              ),
              DropdownButtonFormField<String>(
                hint: Text('Level'),
                onChanged: (value) {
                  onLevelSelected(interest, value);
                },
                value:
                    selectedLevels[interest], // Set the current selected level
                items: getDropdownItems(),
              ),
            ],
          ),
        ),
      );
    }
    return dropdowns;
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    return _levelslist.map((level) {
      return DropdownMenuItem<String>(
        value: level,
        child: Text(level),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
        if (state is OnboardingLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Column(children: [
            Text('reignoroegiorig'),
            ...buildDropdownMenus(),
            InkWell(
              child: CustomFormButton(
                  isLoading: _isLoading,
                  innerText: 'Next',
                  onTap: () {
                   final updatedUser = state.user.copyWith(levels: selectedLevels);
      context.read<OnboardingBloc>().add(
        UpdateUser(
          user: updatedUser,
        ),
      );
    //  context.read<UserProvider>().refreshUser(user: updatedUser);
                    navigateToMobileScreenLayout(                 
                    );
                  }),
            ),
          ]);
        } else {
          return Text('Something went wrong.');
        }
      }),
    );
  }
}
