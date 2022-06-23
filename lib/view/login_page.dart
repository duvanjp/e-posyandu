import 'dart:ui';
import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/view/home_page.dart';
import 'package:e_posyandu/widget/add_input.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  bool _ableToNext = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/logo.png"),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    alignment: Alignment.center,
                    child: Text(
                      "Masukkan akun anda",
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: AddInput(
                      controller: _emailInput,
                      label: "Nama",
                      type: TextInputType.name,
                      hint: "Masukkan nama akun anda",
                      validation: (val) {
                        // if (GlobalHelper.isEmpty(val)) {
                        //   return "Alamat email tidak boleh kosong";
                        // } else if (!val!.contains("@")) {
                        //   return "Format email harus sesuai";
                        // }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: AddInput(
                      controller: _passwordInput,
                      label: "Kata sandi",
                      hint: "Kata sandi akun anda",
                      passwordField: true,
                      onChanged: (val) {
                        setState(() {
                          _ableToNext = val.length >= 8;
                        });
                      },
                      validation: (val) {
                        // if (GlobalHelper.isEmpty(val)) {
                        //   return "Kata sandi tidak boleh kosong";
                        // } else if (val!.length < 8) {
                        //   return "Kata sandi harus lebih dari 8 karakter";
                        // }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        width: double.infinity,
        child: BaseButton(
          style: AppButtonStyle.primary,
          radius: 8,
          padding: 16,
          isDisabled: !_ableToNext,
          text: "Login",
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            // authCubit.auth(_emailInput.text, _passwordInput.text);
          },
        ),
      ),
    );
  }
}
