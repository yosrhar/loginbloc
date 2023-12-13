import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final String? Function(String?) validator;

  CustomTextField({
    Key? key,
    required this.hint,
    this.controller,
    this.onChanged,
    this.validator = _defaultValidator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

String? _defaultValidator(String? value) {
  return null; // Default validator that always returns null (no validation).
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          obscureText: (widget.obscureText && _obscureText),
          decoration: InputDecoration(
            isDense: (widget.isDense != null) ? widget.isDense : false,
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hint,
            contentPadding:
                const EdgeInsets.only(bottom: 5.0, top: 12.5, left: 10),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorText: _errorText,
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
          onChanged: (text) {
            final error = widget.validator(text);
            setState(() {
              _errorText = error;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(text);
            }
          },
        ),
      ),
    );
  }
}

