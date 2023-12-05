import 'package:commerce_app/core/networking/config/appthem.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  double? width;
  double? height;
  BorderRadius borderRadius;
  TextEditingController? controller;
  String? hint;
  String? label;
  Widget? prefixIcon;
  // Widget? suffixIcon;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  // void Function()? onEditingComplete;
  // ValueChanged<String>? onChanged;
  // void Function(PointerDownEvent)? onTapOutside;
  // void Function()? onTap;
  // void Function(String)? onFieldSubmitted;
  bool enabled;
  // FocusNode? focusNode;

  CustomTextField({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(100000)),
    this.controller,
    this.hint,
    this.label,
    this.prefixIcon,
    // this.suffixIcon,
    this.keyboardType,
    this.validator,
    // this.onEditingComplete,
    // this.onChanged,
    // this.onTapOutside,
    // this.onTap,
    // this.onFieldSubmitted,
    this.enabled = true,
    // this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        // focusNode: focusNode,
        // onTap: onTap,
        // // onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        enabled: enabled,
        // onTapOutside: onTapOutside,
        // onChanged: onChanged,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          // suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.fromLTRB(
              12, 12, 8, 15), // Adjust padding as needed

          hintText: hint,
          labelText: label,

          labelStyle: const TextStyle(
            color: AppTheme.neutral400,
            fontSize: AppTheme.font12,
            fontWeight: FontWeight.w400,
          ),

          prefixIcon: prefixIcon,

          hintStyle: const TextStyle(
            color: AppTheme.neutral400,
            fontSize: AppTheme.font10,
            fontWeight: FontWeight.w400,
          ),

          disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppTheme.neutral400, width: 1),
              borderRadius: borderRadius),

          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppTheme.neutral300, width: 1),
              borderRadius: borderRadius),

          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppTheme.neutral100, width: 1),
              borderRadius: borderRadius),

          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppTheme.error, width: 1),
              borderRadius: borderRadius),

          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppTheme.error, width: 1),
              borderRadius: borderRadius),
        ),
        // onEditingComplete: onEditingComplete,
      ),
    );
  }
}
