import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final TextEditingController textEditingController;
  // final TextFieldInput textFieldInput;
  
  const CustomInputField(
      {Key? key,
      // required this.textFieldInput,
      required this.labelText,
      required this.hintText,
      required this.textEditingController,
     required this.validator,
      this.suffixIcon = false,
      this.isDense,
      this.obscureText = false})
      : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Form(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.labelText,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: widget.textEditingController,
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                isDense: (widget.isDense != null) ? widget.isDense : false,
                hintText: widget.hintText,
                suffixIcon: widget.suffixIcon
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_outlined,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                suffixIconConstraints: (widget.isDense != null)
                    ? const BoxConstraints(maxHeight: 33)
                    : null,
              ),
              validator: (textValue) {
                if (widget.validator != null) {
                  final error = widget.validator(textValue!);
                  if (error != null) {
                    return error;
                  }
                }
                return null;
              },
            ),
            if (widget.validator != null && widget.validator(widget.textEditingController.text) != null)
              Text(
                widget.validator(widget.textEditingController.text) ?? '',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

