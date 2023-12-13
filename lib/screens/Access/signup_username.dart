import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginbloc/Authentification/blocs/widgets/custom_image_container.dart';
import 'package:loginbloc/screens/Access/elements/custom_text_field.dart';
import '../../../Authentification/blocs/onboarding/onboarding_bloc.dart';
import 'elements/custom_button.dart';
import 'elements/page_heading.dart';

class UsernameScreen extends StatefulWidget {
  final TabController tabController;

  const UsernameScreen({Key? key, required this.tabController})
      : super(key: key);

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  XFile? _image; // New field to store the selected image
   final _signupFormKey = GlobalKey<FormState>();

  // New callback function to receive the selected image
  void _handleSelectedImage(XFile image) {
    setState(() {
      _image = image;
    });
  }

  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
      if (state is OnboardingLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is OnboardingLoaded) {
        Size size = MediaQuery.of(context).size;
        return Column(children: [
          Form(
            key: _signupFormKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const PageHeading(
                    title: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
 SizedBox(
         
                      child: CustomImageContainer(
                          photoUrl: (_image == null) ? null : _image!.path,
        onImageSelected: _handleSelectedImage, // Pass the call
                      ),
                    ),                  SizedBox(
                    height: 150,
                  ),
                 
                  CustomTextField(
                    //   labelText: 'Name',
                    hint: 'Your name',
                    onChanged: (value) {
                      context.read<OnboardingBloc>().add(
                            UpdateUser(
                              user: state.user.copyWith(username: value),
                            ),
                          );
                    },
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      tabController: widget.tabController, text: 'NEXT STEP'),

                ],
              ),
            ),
          ),
        ]);
      } else {
        return Text('Something went wrong.');
      }
    }
    );
  }
}
