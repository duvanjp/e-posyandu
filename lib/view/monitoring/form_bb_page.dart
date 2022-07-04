import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/widget/add_input.dart';
import 'package:e_posyandu/widget/app_alert_dialog.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';

class FormBBPage extends StatefulWidget {
  FormBBPage({Key? key}) : super(key: key);

  @override
  _FormBBPageState createState() => _FormBBPageState();
}

class _FormBBPageState extends State<FormBBPage> {
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
          "Kontrol Anak",
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
                    label: "Berat Badan",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g 3Kg",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Berat Badan Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Tinggi Badan",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g 3Kg",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Berat Badan Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Keluhan Penyakit Anak",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g Bayi Demam Tinggi",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Keluhan Penyakit Anak Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Frekuensi Nafas",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g 50 per menit",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Frekuensi Nafas Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Frekuensi Denyut Jantung",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g 200 Per Menit",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Frekuensi Denyut Jantung Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Pemeriksaan Diare",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g Tidak Diare",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Pemeriksaan Diare Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Pemeriksaan Ikterus",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g Tidak Ikterus",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Pemeriksaan Ikterus Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Status Imunisasi",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g Sudah Imunisasi Campak",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Status Imunisasi Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Keluhan Lain",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g Anak Hidung Mampet",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Keluhan Lain Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Tindakan",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g Diberi Obat Penurun Panas",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Tindakan Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Nama Pemeriksa",
                    isRequired: true,
                    controller: personalName,
                    hint: "e.g 12 Bidan Dewi",
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Nama Pemeriksa masih kosong";
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
