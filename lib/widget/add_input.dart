import 'package:e_posyandu/app_color.dart';
import 'package:flutter/material.dart';

class AddInput extends StatelessWidget {
  final String? label, hint;
  final TextEditingController? controller;
  final bool? isRequired;
  final TextInputType? type;
  final FormFieldValidator<String>? validation;
  final bool passwordField;
  final ValueChanged<String>? onChanged;

  const AddInput({
    Key? key,
    @required this.label,
    @required this.hint,
    @required this.controller,
    @required this.validation,
    this.isRequired = false,
    this.type = TextInputType.name,
    this.passwordField = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  width: 3,
                ),
                isRequired!
                    ? Text(
                        "*",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColor.red,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          TextFormField(
            validator: validation!,
            controller: controller,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 14,
            ),
            keyboardType: type,
            obscureText: passwordField,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColor.boxGrey,
                  fontWeight: FontWeight.w400),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.boxGrey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary),
              ),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}
