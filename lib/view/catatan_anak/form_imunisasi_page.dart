import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/widget/add_input.dart';
import 'package:e_posyandu/widget/app_alert_dialog.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';

class FormImunisasiPage extends StatefulWidget {
  FormImunisasiPage({Key? key}) : super(key: key);

  @override
  _FormImunisasiPageState createState() => _FormImunisasiPageState();
}

class _FormImunisasiPageState extends State<FormImunisasiPage> {
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
          "Imunisasi",
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
                    label: "Jenis Imunisasi",
                    isRequired: true,
                    controller: storeName,
                    hint: "e.g polio 1",
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Jenis Imunisasi Masih Kosong";
                      }
                      return null;
                    },
                  ),
                  AddInput(
                    label: "Tanggal Imunisasi",
                    isRequired: true,
                    controller: personalName,
                    hint: "e.g 12 januari 2020",
                    type: TextInputType.name,
                    validation: (value) {
                      if (GlobalHelper.isEmpty(value)) {
                        return "Tanggal Imunisasi masih kosong";
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
