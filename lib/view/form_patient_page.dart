import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/widget/add_input.dart';
import 'package:e_posyandu/widget/app_alert_dialog.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';

class FormPatientPage extends StatefulWidget {
  FormPatientPage({Key? key}) : super(key: key);

  @override
  _FormPatientPageState createState() => _FormPatientPageState();
}

class _FormPatientPageState extends State<FormPatientPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController storeName = TextEditingController();
  TextEditingController storeAddress = TextEditingController();
  TextEditingController personalName = TextEditingController();
  TextEditingController personalEmail = TextEditingController();
  TextEditingController personalPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Biodata Pasien",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Form(
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
                    label: "Nama Ibu",
                    isRequired: true,
                    controller: storeName,
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
                    controller: storeName,
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
                    controller: storeName,
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
                    controller: storeName,
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
                    controller: storeName,
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
                    controller: storeName,
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
                    controller: storeName,
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
                    controller: storeName,
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
                    controller: storeName,
                    hint: "e.g Islam",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Agama Suami Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Pendidikan",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g SMA",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Pendidikan Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Pekerjaan Suami",
                    isRequired: true,
                    controller: storeName,
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
                    controller: storeName,
                    hint: "e.g Gampingan",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Alamat Rumah Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Nomor Telepon",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g 08123xxxxx",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Nomor Telepon Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Nomor Telepon",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g 08123xxxxx",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Nomor Telepon Masih Kosong";
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
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: BaseButton(
          style: AppButtonStyle.primary,
          radius: 8,
          padding: 16,
          text: "Simpan Informasi",
          onPressed: () {
            AppAlertDialog(
                    title: 'Konfirmasi perubahan data',
                    description: 'Apakah data yang anda berikan sudah benar?',
                    positiveButtonText: 'Ya',
                    positiveButtonOnTap: () {
                      Navigator.pop(context);
                    },
                    negativeButtonText: 'Tidak',
                    negativeButtonOnTap: () => Navigator.pop(context))
                .show(context);
          },
        ),
      ),
    );
  }
}
