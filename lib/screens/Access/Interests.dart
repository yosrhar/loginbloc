import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:loginbloc/Authentification/provider.dart/user_provider.dart';
import 'package:loginbloc/screens/Access/elements/custom_text_header.dart';
import 'package:loginbloc/screens/Access/level_screen.dart';
import 'package:loginbloc/user_model.dart';
import 'package:loginbloc/utils.dart';
import 'package:provider/provider.dart';
import '../../../Authentification/blocs/onboarding/onboarding_bloc.dart';
import 'elements/custom_button.dart';
import 'elements/custom_form_button.dart';

class InterestsScreen extends StatefulWidget {
  final TabController tabController;
  const InterestsScreen({Key? key, required this.tabController})
      : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
 
  List<String> selectedInterests = [];
  final _interestslist = [
    "Tennis",
    "Chess",
    "Volleyball",
    "Football",
    "Basketball",
    "Gym"
  ];
  bool _isLoading = false;

  void navigateToLevelsScreen(List<String> selectedInterests) {
    if (selectedInterests.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LevelsScreen(
            selectedInterests: selectedInterests,
          ),
        ),
      );
    } else {
      showSnackBar('noooooo',
          context); // Handle the case when selectedInterests is empty or null
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    Size size = MediaQuery.of(context).size;
    double distanceFromBottom = size.height * 0.1;
    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
      if (state is OnboardingLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is OnboardingLoaded) {
        return Column(children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    CustomTextHeader(text: 'Which Sports do you play?'),
                    SizedBox(height: size.height * 0.04),
                    GroupButton(
                        isRadio: false,
                        maxSelected: 4,
                        onSelected:
                            (String selectedType, int index, bool isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedInterests.add(_interestslist[index]);
                            } else {
                              selectedInterests.remove(_interestslist[index]);
                            }
                          });
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user
                                      .copyWith(interests: selectedInterests),
                                ),
                              );
                        },
                        options: GroupButtonOptions(
                          selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.red,
                          ),
                          unselectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          selectedColor: Colors.white,
                          unselectedColor: Colors.grey[300],
                          selectedBorderColor: Colors.red,
                          unselectedBorderColor: Colors.grey[500],
                          borderRadius: BorderRadius.circular(5.0),
                          selectedShadow: <BoxShadow>[
                            BoxShadow(color: Colors.transparent)
                          ],
                          unselectedShadow: <BoxShadow>[
                            BoxShadow(color: Colors.transparent)
                          ],
                        ),
                        buttons: _interestslist),
                  ],
                ),
              ),
            ),
          ),

          InkWell(
            child: CustomFormButton(
                isLoading: _isLoading,
                innerText: 'Next',
                onTap: () {
                  navigateToLevelsScreen(selectedInterests);
                  final updatedUser =
                      state.user.copyWith(interests: selectedInterests);
              //    context.read<UserProvider>().refreshUser(user: updatedUser);
                }),
          ),
        ]);
      } else {
        return Text('Something went wrong.');
      }
    });
  }
}
