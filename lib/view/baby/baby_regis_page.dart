part of '../pages.dart';

class BabyRegisPage extends StatefulWidget {
  final Patient patient;
  BabyRegisPage({Key? key, required this.patient}) : super(key: key);

  @override
  _BabyRegisPageState createState() => _BabyRegisPageState();
}

class _BabyRegisPageState extends State<BabyRegisPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late PatientCubit patientCubit;
  TextEditingController statusAnak = TextEditingController();
  TextEditingController namaAnak = TextEditingController();
  TextEditingController tanggalLahir = TextEditingController();
  TextEditingController beratLahir = TextEditingController();
  TextEditingController panjangBadan = TextEditingController();
  TextEditingController linkarKepala = TextEditingController();
  TextEditingController jenisKelamin = TextEditingController();
  TextEditingController catatanTambahan = TextEditingController();
  bool isBoy = true;

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    jenisKelamin.text = "Laki-Laki";
    super.initState();
  }

  @override
  void dispose() {
    statusAnak.dispose();
    namaAnak.dispose();
    tanggalLahir.dispose();
    beratLahir.dispose();
    panjangBadan.dispose();
    jenisKelamin.dispose();
    catatanTambahan.dispose();
    super.dispose();
  }

  onSaveData() {
    AppAlertDialog(
        title: 'Konfirmasi',
        description: 'Apakah data yang anda berikan sudah benar?',
        positiveButtonText: 'Ya',
        positiveButtonOnTap: () {
          Baby dataBaby = Baby(
              namaAnak: namaAnak.text,
              catatanAnak:
                  catatanTambahan.text.isEmpty ? "-" : catatanTambahan.text,
              lingkarkepalaAnak: linkarKepala.text,
              kelaminAnak: jenisKelamin.text,
              panjangAnak: panjangBadan.text,
              statusAnak: statusAnak.text,
              tgllhrAnak: tanggalLahir.text,
              beratAnak: beratLahir.text);
          patientCubit.saveBabyData(widget.patient.referenceId, dataBaby);
        },
        negativeButtonText: 'Tidak',
        negativeButtonOnTap: () => Navigator.pop(context)).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is BabySavedLoading) {
          progressDialogFull(context);
        } else if (state is BabySavedSuccess) {
          dismissProgressDialogFull(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
              (Route<dynamic> route) => false);
          ScaffoldMessenger.of(context).showSnackBar(snackbarWidget(
              "Sukses menyimpan data!", context,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 150,
                  right: 20,
                  left: 20)));
        }
      },
      child: Scaffold(
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formkey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AddInput(
                          label: "Status Anak",
                          isRequired: true,
                          controller: statusAnak,
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
                          label: "Nama Anak",
                          isRequired: true,
                          controller: namaAnak,
                          type: TextInputType.text,
                          hint: "e.g Dimas Anggar",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Nama Anak masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Tanggal Lahir Anak",
                          isRequired: true,
                          controller: tanggalLahir,
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
                          controller: beratLahir,
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
                          controller: panjangBadan,
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
                          controller: linkarKepala,
                          hint: "20 cm",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Lingkar Kepala Anak Masih Kosong";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Jenis Kelamin Anak",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        isBoy = !isBoy;
                                        jenisKelamin.text = "Laki-Laki";
                                      });
                                    },
                                    child: Row(children: [
                                      Icon(isBoy
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank),
                                      SizedBox(width: 4),
                                      Text(
                                        "Laki-Laki",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ]))
                              ],
                            ),
                            SizedBox(width: 24),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        isBoy = !isBoy;
                                        jenisKelamin.text = "Perempuan";
                                      });
                                    },
                                    child: Row(children: [
                                      Icon(!isBoy
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank),
                                      SizedBox(width: 4),
                                      Text(
                                        "Perempuan",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ]))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AddInput(
                          label: "Catatan Tambahan",
                          hint: " ",
                          controller: catatanTambahan,
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
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              child: BaseButton(
                style: AppButtonStyle.primary,
                radius: 8,
                padding: 16,
                text: "Simpan Informasi",
                onPressed: () {
                  print(jenisKelamin.text);
                  if (formkey.currentState!.validate()) {
                    onSaveData();
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
          ],
        ),
      ),
    );
  }
}

class JenisKelamin {
  final String value;

  JenisKelamin({required this.value});
}
