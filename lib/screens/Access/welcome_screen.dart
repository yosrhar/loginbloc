import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/Authentification/cubits/cubit/signup_cubit.dart';
import 'package:loginbloc/Authentification/repositories/auth/auth_repository.dart';
import 'package:loginbloc/Authentification/responsive/mobileScreenLayout.dart';
import 'package:loginbloc/screens/Access/elements/custom_form_button.dart';
import 'package:loginbloc/screens/Access/elements/custom_input_field.dart';
import 'package:loginbloc/screens/Access/elements/onboarding_screen.dart';
import 'package:loginbloc/screens/Access/elements/page_heading.dart';
import 'package:loginbloc/utils.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (_) =>
            SignupCubit(authRepository: context.read<AuthRepository>()),
        child: WelcomeScreen(),
      ),
    );
  }

  const WelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _loginButtonPressed = false;
  
 String? validateEmail(String? email) {
  // Only show error if the login button has been pressed
  if (_loginButtonPressed) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\. \w{2,3}(\. \w{2,3})?$');

    final isEmailValid = emailRegex.hasMatch(email ?? '');

    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
  }
  return null;
}

String? validatepw(String? password) {
  // Only show error if the login button has been pressed
  if (_loginButtonPressed) {
    if (password == null || password.length < 4) {
      return 'Please Enter Password';
    }
  }
  return null;
}



  // String? validatePassword(String password) {
  //   RegExp passwRegex =
  //       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  //           final isPasswordValid = passwRegex.hasMatch(password);
  //   if (password.isEmpty) {
  //     return 'Please enter password';
  //   } else {
  //     if (!isPasswordValid) {
  //       return 'Enter valid password';
  //     } else {
  //       return null;
  //     }
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
            _loginButtonPressed = true;
    });
    String res = await AuthRepository().loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          //pushreplacement instead of push to not be able to be back to login/signup screen
          builder: (context) => mobileScreenLayout()));
    } else {
      showSnackBar(res, context);
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Color.fromARGB(255, 235, 8, 8),
        body: Container(
          alignment: Alignment.center,
          //   padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/banner.avif'),
              fit: BoxFit.contain,
              alignment: Alignment.topRight,
            ),
          ),

          //const PageHeader(),
          // child: Padding(
          //padding: EdgeInsets.only(top: size.height * 0.3),
//EdgeInsets.fromLTRB(0, size.height * 0.3, 0, 0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.3,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction, // Add this line
                    key: _loginFormKey,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const PageHeading(
                            title: 'Log In',
                          ),
                          CustomInputField(
                            labelText: 'Email',
                            hintText: 'Your email',
                            textEditingController: _emailController,
                            validator: validateEmail,
                        //    autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomInputField(
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscureText: true,
                            suffixIcon: true,
                            textEditingController: _passwordController,
                            validator: validatepw,
                           //  autovalidateMode: AutovalidateMode.onUserInteraction,
                            // (textValue) {
                            //   if (textValue == null || textValue.isEmpty) {
                            //     return 'Password is required!';
                            //   }
                            //   return null;
                            // },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: size.width * 0.80,
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const ForgotPasswordPage()))
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Color(0xff939393),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomFormButton(
                            isLoading: _isLoading,
                            innerText: 'Login',
                            onTap: loginUser,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            width: size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account ? ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff939393),
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OnboardingScreen()))
                                  },
                                  child: const Text(
                                    'Sign-up',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff748288),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLoginUser() {
    // login user
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );
    }
  }
}
