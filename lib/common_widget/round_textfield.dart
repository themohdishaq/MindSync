import 'package:flutter/material.dart';
import 'package:nayapakistan/common/color_extension.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String icon;
  final Widget? rightIcon;
  final bool obscureText;
  final String? label;
  final EdgeInsets? margin;

  const RoundTextField({
    Key? key,
    required this.icon,
    this.controller,
    this.margin,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.rightIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: TColor.lightGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: TColor.gray),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: TColor.blue, width: 2),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15), // Added padding for the icon
            child: Image.asset(
              icon,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: TColor.gray,
            ),
          ),
          suffixIcon: rightIcon,
          hintStyle: TextStyle(color: TColor.gray, fontSize: 12),
        ),
      ),
    );
  }
}
