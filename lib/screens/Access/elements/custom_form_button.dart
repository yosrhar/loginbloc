import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onTap;
  final TextEditingController? emailController;
    final TextEditingController? passwordController;
    

  bool isLoading = false;

  CustomFormButton({
    Key? key,
    required this.innerText,
    required this.onTap,
    required this.isLoading,
    this.emailController,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: <Color>[
          Color(0xffFF4B1F),
          Color.fromARGB(255, 189, 47, 11),
          Color.fromARGB(255, 50, 4, 4),
        ]),
        borderRadius: BorderRadius.circular(26),
      ),
      child: InkWell(
        onTap: onTap,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Center(
                child: Text(
                innerText,
                style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              )),
      ),
    );
  }
}
