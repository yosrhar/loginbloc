import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/screens/Access/elements/custom_checkbox.dart';
import 'package:loginbloc/screens/Access/elements/custom_text_field.dart';
import 'package:loginbloc/screens/Access/elements/custom_text_header.dart';
import '../../../Authentification/blocs/onboarding/onboarding_bloc.dart';
import 'elements/custom_button.dart';
import 'elements/custom_form_button.dart';

class AgeSignupScreen extends StatelessWidget {
  final TabController tabController;

  const AgeSignupScreen({Key? key, required this.tabController})
      : super(key: key);

  @override



  Widget build(BuildContext context) {
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
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 50),
                  child: Column(
                    //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextHeader(text: 'What\'s Your Gender?'),
                          CustomCheckbox(
                            text: 'Male',
                            value: state.user.gender == 'Male',
                            onChanged: (bool? newValue) {
                              if (newValue != null && newValue) {
                                context.read<OnboardingBloc>().add(
                                      UpdateUser(
                                        user: state.user.copyWith(
                                          gender: 'Male',
                                        ),
                                      ),
                                    );
                              }
                              ;
                            },
                          ),
                          CustomCheckbox(
                            text: 'Female',
                            value: state.user.gender == 'Female',
                            onChanged: (bool? newValue) {
                              if (newValue != null && newValue) {
                                context.read<OnboardingBloc>().add(
                                      UpdateUser(
                                        user: state.user.copyWith(
                                          gender: 'Female',
                                        ),
                                      ),
                                    );
                              }
                              ;
                            },
                          ),
                          CustomCheckbox(
                            text: 'Other',
                            value: state.user.gender == 'Other',
                            onChanged: (bool? newValue) {
                              if (newValue != null && newValue) {
                                context.read<OnboardingBloc>().add(
                                      UpdateUser(
                                        user: state.user.copyWith(
                                          gender: 'Other',
                                        ),
                                      ),
                                    );
                              }
                              ;
                            },
                          ),
                          SizedBox(height: size.height * 0.07),
                          CustomTextHeader(text: 'What\'s Your Age?'),
                          CustomTextField(
                            hint: 'ENTER YOUR AGE',
                            onChanged: (value) {
                              context.read<OnboardingBloc>().add(
                                    UpdateUser(
                                      user: state.user
                                          .copyWith(age: int.parse(value)),
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(tabController: tabController, text: 'NEXT STEP'),

          ],
        );
      } else {
        return Text('Something went wrong.');
      }
    });
  }
}
