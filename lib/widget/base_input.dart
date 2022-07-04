import 'package:e_posyandu/app_color.dart';
import 'package:flutter/material.dart';

class BaseInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool? passwordField;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final VoidCallback? onClick;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final TextCapitalization? textCapitalization;
  final Color? backgroundColor;
  final ValueChanged<String>? onChanged;

  BaseInput(
      {@required this.controller,
      @required this.label,
      this.hint,
      this.passwordField = false,
      this.onClick,
      this.keyboardType = TextInputType.text,
      this.suffixWidget,
      this.validator,
      this.maxLines,
      this.textCapitalization,
      this.backgroundColor,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    if (onClick != null) {
      return Stack(
        children: [
          _buildTextFormField(context),
          Container(
            height: 40,
            width: double.infinity,
            child: GestureDetector(
              onTap: onClick,
            ),
          )
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label!,
          //   style: TextStyle(
          //     color: AppColor.black,
          //     fontSize: 12.sp,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: _buildTextFormField(context),
          ),
        ],
      );
    }
  }

  Widget _buildTextFormField(context) {
    return TextFormField(
      controller: controller,
      keyboardType: maxLines != null ? TextInputType.multiline : keyboardType,
      maxLines: maxLines,
      obscureText: passwordField!,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      readOnly: onClick != null,
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
          ),
          filled: backgroundColor != null ? true : false,
          hintText: hint,
          hintStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: AppColor.boxGrey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.boxGrey, width: 1.5)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.boxGrey, width: 1.5)),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          fillColor: backgroundColor ?? Colors.transparent,
          focusColor: backgroundColor ?? Colors.transparent,
          suffixIcon: suffixWidget ?? Container(width: 2)),
    );
  }
}
