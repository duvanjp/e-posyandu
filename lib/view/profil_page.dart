import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/bloc/user/user_cubit.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/view/pages.dart';
import 'package:e_posyandu/widget/add_input.dart';
import 'package:e_posyandu/widget/app_alert_dialog.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:e_posyandu/widget/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late UserCubit userCubit;

  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController posyandu = TextEditingController();
  TextEditingController posyanduAddress = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    userCubit = BlocProvider.of<UserCubit>(context);
    fullname.text = userCubit.user!.namaPetugas;
    posyandu.text = userCubit.user!.namaPosyandu;
    address.text = userCubit.user!.alamatPetugas;
    posyanduAddress.text = userCubit.user!.alamatPosyandu;
    phone.text = userCubit.user!.nomorPetugas;
    email.text = userCubit.user!.email;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Profil Petugas",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppAlertDialog(
                  title: 'Keluar',
                  description: 'Apakah anda yakin ingin keluar dari akun ini ?',
                  positiveButtonText: 'Ya',
                  positiveButtonOnTap: () {
                    userCubit.logOut();
                  },
                  negativeButtonText: 'Tidak',
                  negativeButtonOnTap: () =>
                      Navigator.pop(context)).show(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserNotLoggedIn) {
            GlobalHelper().toWelcomePage(context);
          } else if (state is UserLoading) {
            progressDialogFull(context);
          }
        },
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formkey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    AddInput(
                      label: "Nama Lengkap Petugas",
                      isRequired: true,
                      enabled: false,
                      controller: fullname,
                      hint: "e.g siti nurhaliza",
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Nama lengkap petugas masih kosong";
                        }
                        return null;
                      },
                    ),
                    AddInput(
                      label: "Alamat Petugas",
                      isRequired: true,
                      controller: address,
                      enabled: false,
                      hint: "Jalan merauke",
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Alamat petugas masih kosong";
                        }
                        return null;
                      },
                    ),
                    AddInput(
                      label: "Nama Posyandu",
                      isRequired: true,
                      controller: posyandu,
                      enabled: false,
                      hint: "Posyandu Merdeka",
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Nama posyandu masih kosong";
                        }
                        return null;
                      },
                    ),
                    AddInput(
                      label: "Alamat Posyandu",
                      isRequired: true,
                      controller: posyanduAddress,
                      enabled: false,
                      hint: "Jalan merauke",
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Alamat posyandu masih kosong";
                        }
                        return null;
                      },
                    ),
                    AddInput(
                      label: "Nomor Telepon",
                      controller: phone,
                      enabled: false,
                      hint: "08127371232",
                      type: TextInputType.phone,
                      validation: (value) {
                        return null;
                      },
                    ),
                    AddInput(
                      label: "Email",
                      hint: "joko@gmail.com",
                      controller: email,
                      enabled: false,
                      isRequired: true,
                      type: TextInputType.number,
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Email masih kosong";
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // bottomSheet: Container(
      //   color: Colors.white,
      //   padding: const EdgeInsets.all(15),
      //   width: double.infinity,
      //   child: BaseButton(
      //     style: AppButtonStyle.primary,
      //     radius: 8,
      //     padding: 16,
      //     text: "Simpan Informasi",
      //     onPressed: () {
      //       AppAlertDialog(
      //               title: 'Konfirmasi perubahan data',
      //               description: 'Apakah data yang anda berikan sudah benar?',
      //               positiveButtonText: 'Ya',
      //               positiveButtonOnTap: () {
      //                 Navigator.pop(context);
      //               },
      //               negativeButtonText: 'Tidak',
      //               negativeButtonOnTap: () => Navigator.pop(context))
      //           .show(context);
      //     },
      // ),
      // ),
    );
  }
}
