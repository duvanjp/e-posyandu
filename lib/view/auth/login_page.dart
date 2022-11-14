part of '../pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  bool _ableToNext = false;

  late UserCubit userCubit;
  late PatientCubit patientCubit;

  String result = "";

  @override
  void initState() {
    userCubit = BlocProvider.of<UserCubit>(context);
    patientCubit = BlocProvider.of<PatientCubit>(context);
    // dummy account admin
    // _usernameInput.text = "081234567890";
    // _passwordInput.text = "12345678";
    // dummy account patient
    // _usernameInput.text = "sumiati_wiri";
    // _passwordInput.text = "12345678";
    _ableToNext = true;
    super.initState();
  }

  onLogin() async {
    if (_usernameInput.text == "Admin-Petugas") {
      //for admin
      userCubit.login(_usernameInput.text, _passwordInput.text);
    } else {
      patientCubit.login(_usernameInput.text, _passwordInput.text);
    }
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      NdefMessage? message = await ndef?.read();
      NdefRecord? value = message?.records[0];

      List<int> list = value!.payload;
      Uint8List bytes = Uint8List.fromList(list);
      String string = String.fromCharCodes(bytes);
      print(string);
      if (string.contains('-')) {
        String username = string.split('-')[1];
        String password = string.split('-')[2];
        print("username:$username | password:$password");
        patientCubit.login(username, password);
      } else {
        dismissProgressDialogFull(context);
        AppAlertDialog(
            title: 'Pesan',
            description: 'Kartu NFC tidak valid!',
            negativeButtonText: 'Tutup',
            negativeButtonOnTap: () => Navigator.pop(context)).show(context);
      }

      NfcManager.instance.stopSession();
    });
  }

  @override
  void dispose() {
    _usernameInput.dispose();
    _passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: userCubit,
          listener: (context, state) {
            if (state is UserLoggedIn) {
              dismissProgressDialogFull(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()),
                  (Route<dynamic> route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                snackbarWidget("Anda berhasil login!", context,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 150,
                        right: 20,
                        left: 20)),
              );
            } else if (state is UserFailedLogin) {
              dismissProgressDialogFull(context);
              AppAlertDialog(
                      title: 'Pesan',
                      description: 'Akun tidak ditemukan!',
                      negativeButtonText: 'Tutup',
                      negativeButtonOnTap: () => Navigator.pop(context))
                  .show(context);
            } else if (state is UserLoading) {
              print("Masuk Loading Admin");
              // progressDialogFull(context);
            }
          },
        ),
        BlocListener<PatientCubit, PatientState>(
          listener: (context, state) {
            if (state is PatientLoading) {
              print("Masuk Loading Pasien");
              // progressDialogFull(context);
            } else if (state is PatientLoginSuccess) {
              dismissProgressDialogFull(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CatatanPage(patient: state.patient, isAdmin: false)
                      // PatientHomePage(patient: state.patient),
                      ),
                  (Route<dynamic> route) => false);
              ScaffoldMessenger.of(context).showSnackBar(snackbarWidget(
                  "Anda berhasil login!", context,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 150,
                      right: 20,
                      left: 20)));
            } else if (state is PatientExist) {
              dismissProgressDialogFull(context);
              AppAlertDialog(
                      title: 'Pesan',
                      description: 'Akun tidak ditemukan!',
                      negativeButtonText: 'Tutup',
                      negativeButtonOnTap: () => Navigator.pop(context))
                  .show(context);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: AddInput(
                            controller: _usernameInput,
                            label: "Username",
                            type: TextInputType.name,
                            hint: "Masukkan username akun anda",
                            validation: (val) {
                              if (GlobalHelper.isEmpty(val)) {
                                return "Username tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
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
                              if (GlobalHelper.isEmpty(val)) {
                                return "Kata sandi tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    AppAlertDialog(
                            title: 'Login dengan Kartu NFC',
                            description:
                                'Pastikan fitur NFC pada device Anda menyala!',
                            positiveButtonText: 'Login',
                            positiveButtonOnTap: () async {
                              progressDialogFull(context);
                              await Future.delayed(Duration(milliseconds: 500));
                              bool isNFCAvailable =
                                  await NfcManager.instance.isAvailable();
                              print(isNFCAvailable);

                              if (isNFCAvailable) {
                                _tagRead();
                              } else {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                AppAlertDialog(
                                    title: 'Pesan',
                                    description:
                                        'Device Anda tidak memiliki fitur NFC!',
                                    negativeButtonText: 'Tutup',
                                    negativeButtonOnTap: () =>
                                        Navigator.pop(context)).show(context);
                              }
                            },
                            negativeButtonText: 'Cancel',
                            negativeButtonOnTap: () => Navigator.pop(context))
                        .show(context);
                  },
                  child: Text(
                    'Login menggunakan kartu NFC',
                    style: TextStyle(fontSize: 14, color: AppColor.darkGrey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  width: double.infinity,
                  child: BaseButton(
                    style: AppButtonStyle.primary,
                    radius: 8,
                    padding: 16,
                    isDisabled: !_ableToNext,
                    text: "Login",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        progressDialogFull(context);
                        await Future.delayed(Duration(milliseconds: 500));
                        onLogin();
                      } else {
                        AppAlertDialog(
                            title: 'Pesan',
                            description: 'Lengkapi semua data!',
                            negativeButtonText: 'Tutup',
                            negativeButtonOnTap: () =>
                                Navigator.pop(context)).show(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
