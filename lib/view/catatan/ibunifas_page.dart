import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/widget/add_input.dart';
import 'package:e_posyandu/widget/app_alert_dialog.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';

class IbunifasPage extends StatefulWidget {
  IbunifasPage({Key? key}) : super(key: key);

  @override
  _IbunifasPageState createState() => _IbunifasPageState();
}

class _IbunifasPageState extends State<IbunifasPage> {
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
          "Kesehatan Ibu Nifas",
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
                    label: "Keluhan Sekarang",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g sakit perut",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Keluhan masih kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Tekanan Darah",
                    isRequired: true,
                    controller: personalName,
                    hint: "e.g 120",
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Tekanan Darah masih kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Berat Badan",
                    isRequired: true,
                    controller: storeAddress,
                    hint: "80 Kg",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Berat masih kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Denyut Jantung / Menit",
                    hint: " ",
                    controller: personalName,
                    isRequired: true,
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Denyut Jantung Masih kosong";
                      }

                      return null;
                    },
                  ),
                  AddInput(
                    label: "Kaki Bengkak",
                    hint: " ",
                    controller: personalName,
                    isRequired: true,
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Kaki Bengkak Masih kosong";
                      }

                      return null;
                    },
                  ),
                  AddInput(
                    label: "Hasil Laboratorium",
                    hint: " ",
                    controller: personalName,
                    isRequired: true,
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Hasil Laboratorium Masih kosong";
                      }

                      return null;
                    },
                  ),
                  AddInput(
                    label: "Tindakan",
                    hint: " ",
                    controller: personalName,
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value))
                      return null;
                    },
                  ),
                   AddInput(
                    label: "Tempat Pemeriksaan",
                    hint: "Posyandu Setempat",
                    controller: personalName,
                    isRequired: true,
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Tempat Pemeriksaan Masih kosong";
                      }

                      return null;
                    },
                  ),
                  AddInput(
                    label: "Kontrol Selanjutnya (Tanggal)",
                    hint: " ",
                    controller: personalName,
                    isRequired: true,
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Kontrol Selanjutnya Masih kosong";
                      }

                      return null;
                    },
                  ),
                  AddInput(
                    label: "Catatan Tambahan",
                    hint: " ",
                    controller: personalName,
                    type: TextInputType.name,
                    validation: (value) {
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Catatan Tambahan",
                    hint: " ",
                    controller: personalName,
                    type: TextInputType.name,
                    validation: (value) {
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
