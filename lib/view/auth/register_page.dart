part of '../pages.dart';

class RegisterPage extends StatefulWidget {
  final Patient? patient;
  RegisterPage({
    Key? key,
    this.patient,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController konfirmasiPassword = TextEditingController();
  TextEditingController namaIbu = TextEditingController();
  TextEditingController ttlIbu = TextEditingController();
  TextEditingController agamaIbu = TextEditingController();
  TextEditingController pendidikanIbu = TextEditingController();
  TextEditingController golonganDarah = TextEditingController();
  TextEditingController pekerjaanIbu = TextEditingController();
  TextEditingController namaSuami = TextEditingController();
  TextEditingController ttlSuami = TextEditingController();
  TextEditingController agamaSuami = TextEditingController();
  TextEditingController pendidikanSuami = TextEditingController();
  TextEditingController pekerjaanSuami = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController noHandphoneSuami = TextEditingController();
  TextEditingController noHandphoneIbu = TextEditingController();
  bool isPersonalInfo = true;
  bool isAccountInfo = true;
  bool isDisabledRegis = true;
  late PatientCubit patientCubit;

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    if (widget.patient != null) {
      final patient = widget.patient;
      username.text = patient!.username;
      password.text = patient.password;
      konfirmasiPassword.text = patient.password;
      namaIbu.text = patient.namaIbu;
      ttlIbu.text = patient.ttlIbu;
      agamaIbu.text = patient.agamaIbu;
      pendidikanIbu.text = patient.pendidikanIbu;
      golonganDarah.text = patient.goldarahIbu;
      pekerjaanIbu.text = patient.pekerjaanIbu;
      namaSuami.text = patient.namaSuami;
      ttlSuami.text = patient.ttlSuami;
      agamaSuami.text = patient.agamaSuami;
      pendidikanSuami.text = patient.pendidikanSuami;
      pekerjaanSuami.text = patient.pekerjaanSuami;
      alamat.text = patient.alamatRumah;
      noHandphoneIbu.text = patient.noTelp;
    }

    // dummy data
    // username.text = "sumiati_wiri";
    // password.text = "12345678";
    // konfirmasiPassword.text = "12345678";
    // namaIbu.text = "Sumiati";
    // ttlIbu.text = "Malang, 12 Januari 1994";
    // agamaIbu.text = "Islam";
    // pendidikanIbu.text = "Sarjana";
    // golonganDarah.text = "AB";
    // pekerjaanIbu.text = "Ibu Rumah Tangga";
    // namaSuami.text = "Sumiajo";
    // ttlSuami.text = "Malang, 10 Desember 1990";
    // agamaSuami.text = "Islam";
    // pendidikanSuami.text = "Sarjana";
    // pekerjaanSuami.text = "Karyawan Swasta";
    // alamat.text = "Jalan Malang Kenangan Indah 1/8 Malang";
    // noHandphoneIbu.text = "099899878876";
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    konfirmasiPassword.dispose();
    namaIbu.dispose();
    ttlIbu.dispose();
    agamaIbu.dispose();
    pendidikanIbu.dispose();
    golonganDarah.dispose();
    pekerjaanIbu.dispose();
    namaSuami.dispose();
    ttlSuami.dispose();
    agamaSuami.dispose();
    pendidikanSuami.dispose();
    pekerjaanSuami.dispose();
    alamat.dispose();
    noHandphoneSuami.dispose();
    noHandphoneIbu.dispose();
    super.dispose();
  }

  onRegisPatient() {
    AppAlertDialog(
        title: 'Konfirmasi pendaftaran',
        description: 'Apakah data yang anda berikan sudah benar?',
        positiveButtonText: 'Ya',
        positiveButtonOnTap: () {
          Patient patient = Patient(
            username: username.text,
            password: password.text,
            agamaIbu: agamaIbu.text,
            agamaSuami: agamaSuami.text,
            alamatRumah: alamat.text,
            goldarahIbu: golonganDarah.text,
            namaIbu: namaIbu.text,
            namaSuami: namaSuami.text,
            noTelp: noHandphoneIbu.text,
            pekerjaanIbu: pekerjaanIbu.text,
            pekerjaanSuami: pekerjaanSuami.text,
            pendidikanIbu: pendidikanIbu.text,
            pendidikanSuami: pendidikanSuami.text,
            ttlIbu: ttlIbu.text,
            ttlSuami: ttlSuami.text,
          );
          if (widget.patient != null) {
            patient.referenceId = widget.patient!.referenceId;
            patientCubit.editDataPatient(patient);
          } else {
            patientCubit.register(patient);
          }
        },
        negativeButtonText: 'Tidak',
        negativeButtonOnTap: () => Navigator.pop(context)).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColor.black,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<PatientCubit, PatientState>(
          listener: (context, state) async {
            if (state is PatientLoading) {
              dismissProgressDialogFull(context);
              progressDialogFull(context);
            } else if (state is PatientExist) {
              dismissProgressDialogFull(context);
              AppAlertDialog(
                      title: 'Pesan',
                      description: 'Akun sudah ada!',
                      negativeButtonText: 'Tutup',
                      negativeButtonOnTap: () => Navigator.pop(context))
                  .show(context);
            } else if (state is PatientRegisSuccess) {
              bool isAdmin = await ConstantHelper.isPatient();
              if (!isAdmin) {
                dismissProgressDialogFull(context);
                AppAlertDialog(
                    title: 'Selamat!',
                    description:
                        'Akun berhasil terdaftar! Buat kartu NFC sekarang.',
                    positiveButtonText: 'Ya',
                    positiveButtonOnTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateNfcPage(patient: state.patient)),
                          (Route<dynamic> route) => false);
                    },
                    negativeButtonText: 'Skip',
                    negativeButtonOnTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()),
                        (Route<dynamic> route) => false)).show(context);
              } else {
                dismissProgressDialogFull(context);
                print("sukses mendaftar");
                GlobalHelper().toWelcomePage(context);
                ScaffoldMessenger.of(context).showSnackBar(snackbarWidget(
                    "Selamat! Akun berhasil terdaftar, silahkan login",
                    context));
              }
            } else if (state is EditPatientLoading) {
              dismissProgressDialogFull(context);
              progressDialogFull(context);
            } else if (state is EditPatientRegisSuccess) {
              bool isAdmin = await ConstantHelper.isPatient();
              if (!isAdmin) {
                dismissProgressDialogFull(context);
                print("sukses mengedit data");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()),
                    (Route<dynamic> route) => false);
                ScaffoldMessenger.of(context).showSnackBar(snackbarWidget(
                    "Data berhasil di perbarui", context,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 150,
                        right: 20,
                        left: 20)));
              } else {
                dismissProgressDialogFull(context);
                print("sukses mengedit data");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CatatanPage(
                            patient: state.patient, isAdmin: false)),
                    (Route<dynamic> route) => false);
                ScaffoldMessenger.of(context).showSnackBar(snackbarWidget(
                    "Data berhasil di perbarui", context,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 150,
                        right: 20,
                        left: 20)));
              }
            } else if (state is EditPatientRegisFailed) {
              dismissProgressDialogFull(context);
              AppAlertDialog(
                      title: 'Pesan',
                      description: state.error,
                      negativeButtonText: 'Tutup',
                      negativeButtonOnTap: () => Navigator.pop(context))
                  .show(context);
            }
          },
          child: _bodyRegister(context)),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: BaseButton(
          style: AppButtonStyle.primary,
          radius: 8,
          padding: 16,
          text: widget.patient != null ? "Simpan Perubahan" : "Mendaftar",
          onPressed: () {
            if (formkey.currentState!.validate()) {
              onRegisPatient();
            } else {
              AppAlertDialog(
                      title: 'Pesan',
                      description: 'Lengkapi semua data!',
                      negativeButtonText: 'Tutup',
                      negativeButtonOnTap: () => Navigator.pop(context))
                  .show(context);
            }
          },
        ),
      ),
    );
  }

  Form _bodyRegister(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formkey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.patient != null
                  ? "Edit Data"
                  : "Masukkan informasi\nakun Anda",
              style: TextStyle(
                color: AppColor.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            _tabInfo(context, () {
              setState(() {
                isAccountInfo = !isAccountInfo;
              });
            }, "Akun", isAccountInfo),
            dataAkun(),
            SizedBox(height: isAccountInfo ? 0 : 16),
            _tabInfo(context, () {
              setState(() {
                isPersonalInfo = !isPersonalInfo;
              });
            }, "Data Pribadi", isPersonalInfo),
            dataPribadi(),
            SizedBox(height: 80)
          ],
        ),
      ),
    );
  }

  InkWell _tabInfo(
      BuildContext context, Function onTap, String title, bool isExpand) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: AppColor.primary, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Icon(
              isExpand
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_up_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget dataAkun() {
    return Visibility(
        visible: isAccountInfo,
        child: Container(
          padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: Column(
            children: [
              AddInput(
                label: "Username",
                isRequired: true,
                controller: username,
                enabled: widget.patient != null ? false : true,
                hint: "e.g sumiati_wiri",
                validation: (value) {
                  if (GlobalHelper.isEmpty(value)) {
                    return "Username Masih Kosong";
                  }
                  return null;
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AddInput(
                  controller: password,
                  label: "Kata sandi",
                  hint: "Kata sandi akun anda",
                  passwordField: true,
                  validation: (val) {
                    print(val);
                    if (GlobalHelper.isEmpty(val)) {
                      return "Kata Sandi Masih Kosong";
                    } else if (val!.length < 8) {
                      return "Kata sandi harus lebih dari 8 karakter";
                    } else if (val.contains(RegExp(r'[A-Z]')) == false) {
                      print("masuk AZ");
                      return "Harus gabungan antara huruf, angka, kapital, dan non kapital";
                    } else if (val.contains(RegExp(r'[0-9]')) == false) {
                      print("masuk 09");
                      return "Harus gabungan antara huruf, angka, kapital, dan non kapital";
                    } else if (val.contains(RegExp(r'[a-z]')) == false) {
                      print("masuk ab");
                      return "Harus gabungan antara huruf, angka, kapital, dan non kapital";
                    }
                    return null;
                  },
                ),
              ),
              AddInput(
                controller: konfirmasiPassword,
                label: "Konfirmasi Kata sandi",
                hint: "Konfirmasi Kata sandi akun anda",
                passwordField: true,
                validation: (val) {
                  if (GlobalHelper.isEmpty(val)) {
                    return "Kata Sandi Masih Kosong";
                  } else if (val!.length < 8) {
                    return "Kata sandi harus lebih dari 8 karakter";
                  } else if (password.text != konfirmasiPassword.text) {
                    return "Konfirmasi kata sandi tidak sesuai";
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }

  Widget dataPribadi() {
    return Visibility(
      visible: isPersonalInfo,
      child: Container(
        padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        child: Column(
          children: [
            AddInput(
              label: "Nama Ibu",
              isRequired: true,
              controller: namaIbu,
              hint: "e.g Sumiati",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Nama Ibu Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Tempat/Tanggal Lahir",
              isRequired: true,
              controller: ttlIbu,
              hint: "e.g Malang 12 Januari 1994",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Tempat/Tanggal Lahir Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Agama Ibu",
              isRequired: true,
              controller: agamaIbu,
              hint: "e.g Islam",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Agama Ibu Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Pendidikan",
              isRequired: true,
              controller: pendidikanIbu,
              hint: "e.g SMA",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Pendidikan Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Golongan Darah",
              isRequired: true,
              controller: golonganDarah,
              hint: "e.g A",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Golongan Darah Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Pekerjaan Ibu",
              isRequired: true,
              controller: pekerjaanIbu,
              hint: "e.g Ibu Rumah Tangga",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Pekerjaan Ibu Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Nama Suami",
              isRequired: true,
              controller: namaSuami,
              hint: "e.g Mahendra",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Nama Suami Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Tempat/Tanggal Lahir",
              isRequired: true,
              controller: ttlSuami,
              hint: "e.g Malang 12 Januari 1994",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Tempat/Tanggal Lahir Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Agama Suami",
              isRequired: true,
              controller: agamaSuami,
              hint: "e.g Islam",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Agama Suami Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Pendidikan Suami",
              isRequired: true,
              controller: pendidikanSuami,
              hint: "e.g SMA",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Pendidikan Suami Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Pekerjaan Suami",
              isRequired: true,
              controller: pekerjaanSuami,
              hint: "e.g Polisi",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Pekerjaan Suami Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Alamat Rumah",
              isRequired: true,
              controller: alamat,
              hint: "e.g Gampingan",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Alamat Rumah Masih Kosong";
                }
                return null;
              },
            ),
            AddInput(
              label: "Nomor Hp Ibu",
              isRequired: true,
              controller: noHandphoneIbu,
              hint: "e.g 08123xxxxx",
              validation: (value) {
                if (GlobalHelper.isEmpty(value)) {
                  return "Nomor Hp Masih Kosong";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
