import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/widget/add_input.dart';
import 'package:e_posyandu/widget/app_alert_dialog.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';

class bayilahirPage extends StatefulWidget {
  bayilahirPage({Key? key}) : super(key: key);

  @override
  _bayilahirPageState createState() => _bayilahirPageState();
}

class _bayilahirPageState extends State<bayilahirPage> {
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
          "Kesehatan Bayi Baru Lahir",
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
                    label: "Status Anak",
                    isRequired: true,
                    controller: storeName,
                    type: TextInputType.text,
                    hint: "e.g Anak Pertama",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Status Anak masih kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Tanggal Lahir Anak",
                    isRequired: true,
                    controller: personalName,
                    hint: "e.g 8 12 Januari 2022",
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Tanggal Lahir Anak masih kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Berat Lahir Anak",
                    controller: storeAddress,
                    hint: "8 Kg",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Berat Lahir Anak Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Panjang Badan Anak",
                    isRequired: true,
                    controller: storeAddress,
                    hint: "60 cm",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Panjang Badan Anak masih kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Lingkar Kepala Anak",
                    controller: storeAddress,
                    hint: "20 cm",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Lingkar Kepala Anak Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Jenis Kelamin Anak",
                    controller: storeAddress,
                    hint: "Laki-Laki / Perempuan",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Jenis Kelamin Anak Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Catatan Tambahan",
                    hint: " ",
                    controller: personalEmail,
                    type: TextInputType.text,
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
