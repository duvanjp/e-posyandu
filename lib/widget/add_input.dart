import 'package:e_posyandu/app_color.dart';
import 'package:flutter/material.dart';

class AddInput extends StatefulWidget {
  final String? label, hint;
  final TextEditingController? controller;
  final bool? isRequired;
  final TextInputType? type;
  final FormFieldValidator<String>? validation;
  final bool passwordField;
  final ValueChanged<String>? onChanged;
  final String suffixText;
  final bool enabled;

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
    this.suffixText = "",
    this.enabled = true,
  }) : super(key: key);

  @override
  State<AddInput> createState() => _AddInputState();
}

class _AddInputState extends State<AddInput> {
  bool isShowed = true;
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
                  widget.label!,
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
                widget.isRequired!
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
            validator: widget.validation!,
            controller: widget.controller,
            enabled: widget.enabled,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 14,
            ),
            keyboardType: widget.type,
            obscureText: widget.passwordField ? isShowed : false,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
                hintText: widget.hint,
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
                suffix: widget.passwordField
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isShowed = !isShowed;
                          });
                        },
                        child: Icon(
                          isShowed ? Icons.visibility : Icons.visibility_off,
                          color: AppColor.primary,
                        ),
                      )
                    : null,
                suffixText: widget.suffixText == "" ? null : widget.suffixText),
          ),
        ],
      ),
    );
  }
}
