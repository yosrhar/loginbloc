import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/Authentification/cubits/cubit/signup_cubit.dart';
import 'package:loginbloc/screens/Access/elements/custom_text_field.dart';
import 'package:loginbloc/screens/Access/elements/custom_text_header.dart';
import '../../../Authentification/blocs/onboarding/onboarding_bloc.dart';
import 'elements/custom_button.dart';

class EmailSignupScreen extends StatefulWidget {
    final TabController tabController;

  const EmailSignupScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  @override


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Container(
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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextHeader(
                                text: 'What\'s Your Email Adress?'),
                            SizedBox(height: size.height * 0.02),
                            CustomTextField(
                              hint: 'ENTER YOUR EMAIL',
                              onChanged: (value) {
                                context.read<SignupCubit>().emailChanged(value);                       
                                print(state.email);   
                                                           
                              },
                            ),
                            SizedBox(height: size.height * 0.15),
                            CustomTextHeader(text: 'Choose a Password'),
                            SizedBox(height: size.height * 0.02),
                            CustomTextField(
                              hint: 'ENTER YOUR PASSWORD',
                              onChanged: (value) {
                                context
                                    .read<SignupCubit>()
                                    .passwordChanged(value);
                                print(state.password);
                              },
                            ),
                          ],
                        ),
                      ),
                      //      SizedBox(height: size.height*0.4),
                    ],
                  ),
                ),
              ),
              CustomButton(tabController: widget.tabController, text: 'NEXT STEP'),

            ],
          ),
        );
      },
    );
  }
}

