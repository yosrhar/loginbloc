import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/Authentification/blocs/onboarding/onboarding_bloc.dart';
import 'package:loginbloc/Authentification/cubits/cubit/signup_cubit.dart';
import 'package:loginbloc/user_model.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final void function;
  final Function? onPressed;

  CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
    this.function,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (tabController.index == 4) {
            Navigator.pushNamed(context, '/');
          } else {
            tabController.animateTo(tabController.index + 1);
          }

          if (tabController.index == 1) {
            await context.read<SignupCubit>().signUpWithCredentials();

            User user = User(
              uid: context.read<SignupCubit>().state.user!.uid,
              username: '',
              age: 0,
              location: '',
              gender: '',
              levels: {},
              photoUrl: '',
              interests: [],
              email: context.read<SignupCubit>().state.user!.email!,
            );
            context.read<OnboardingBloc>().add(
                  StartOnboarding(
                    user: user,
                  ),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.black, 
          elevation: 0,
        ),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
