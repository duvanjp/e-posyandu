part of '../pages.dart';

class PregnantFormPage extends StatefulWidget {
  final Patient patient;
  PregnantFormPage({Key? key, required this.patient}) : super(key: key);

  @override
  _PregnantFormPageState createState() => _PregnantFormPageState();
}

class _PregnantFormPageState extends State<PregnantFormPage> {
  late PatientCubit patientCubit;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController keluhanSekarang = TextEditingController();
  TextEditingController tekananDarah = TextEditingController();
  TextEditingController beratBadan = TextEditingController();
  TextEditingController umurKehamilan = TextEditingController();
  TextEditingController tinggiFundus = TextEditingController();
  TextEditingController letakJanin = TextEditingController();
  TextEditingController denyutJanin = TextEditingController();
  TextEditingController kakiBengkak = TextEditingController();
  TextEditingController hasilLab = TextEditingController();
  TextEditingController tindakan = TextEditingController();
  TextEditingController tempatPemeriksaan = TextEditingController();
  TextEditingController kontrolSelanjutnya = TextEditingController();
  TextEditingController catatanTambahan = TextEditingController();
  late String dateNow;

  @override
  void dispose() {
    keluhanSekarang.dispose();
    tekananDarah.dispose();
    beratBadan.dispose();
    umurKehamilan.dispose();
    tinggiFundus.dispose();
    letakJanin.dispose();
    denyutJanin.dispose();
    kakiBengkak.dispose();
    hasilLab.dispose();
    tindakan.dispose();
    tempatPemeriksaan.dispose();
    kontrolSelanjutnya.dispose();
    catatanTambahan.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final date = DateFormat.yMMMMEEEEd('id_ID');
    dateNow = date.format(DateTime.now());
    patientCubit = BlocProvider.of<PatientCubit>(context);
    super.initState();
  }

  onSaveData() {
    AppAlertDialog(
        title: 'Konfirmasi',
        description: 'Apakah data yang anda berikan sudah benar?',
        positiveButtonText: 'Ya',
        positiveButtonOnTap: () {
          Pregnant pregnant = Pregnant(
              tanggalPengecekan: dateNow,
              keluhanSekarang: keluhanSekarang.text,
              tekananDarah: tekananDarah.text,
              beratBadan: beratBadan.text,
              umurKehamilan: umurKehamilan.text,
              tinggiFundus: tinggiFundus.text,
              letakJanin: letakJanin.text,
              denyutJantungJanin: denyutJanin.text,
              kakiBengkak: kakiBengkak.text,
              hasilLaboratorium: hasilLab.text,
              tindakan: tindakan.text,
              tempatPemeriksaan: tempatPemeriksaan.text,
              kontrolSelanjutnya: kontrolSelanjutnya.text,
              catatanTambahan: catatanTambahan.text);
          patientCubit.savePregnantData(widget.patient.referenceId, pregnant);
        },
        negativeButtonText: 'Tidak',
        negativeButtonOnTap: () => Navigator.pop(context)).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is PregnantSaveLoading) {
          progressDialogFull(context);
        } else if (state is PregnantSaveSuccess) {
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
            "Kesehatan Ibu Hamil",
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
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formkey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                      children: [
                        TextItemWidget(title: "Tanggal: ", text: dateNow),
                        Divider(),
                        AddInput(
                          label: "Keluhan Sekarang",
                          isRequired: true,
                          controller: keluhanSekarang,
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
                          controller: tekananDarah,
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
                          controller: beratBadan,
                          hint: "80 Kg",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Berat masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Umur Kehamilan (minggu)",
                          isRequired: true,
                          controller: umurKehamilan,
                          hint: "2 Minggu",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Umur Kehamilan masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Tinggi Fundus (cm)",
                          isRequired: true,
                          controller: tinggiFundus,
                          hint: "20 cm",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Tinggi Fundus masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Letak Janin",
                          isRequired: true,
                          controller: letakJanin,
                          hint: " ",
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Letak Janin Masih Kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Denyut Jantung Janin / Menit",
                          hint: " ",
                          controller: denyutJanin,
                          isRequired: true,
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Denyut Jantung Janin Masih kosong";
                            }

                            return null;
                          },
                        ),
                        AddInput(
                          label: "Kaki Bengkak",
                          hint: " ",
                          controller: kakiBengkak,
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
                          controller: hasilLab,
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
                          controller: tindakan,
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) return null;
                          },
                        ),
                        AddInput(
                          label: "Tempat Pemeriksaan",
                          hint: "Posyandu Setempat",
                          controller: tempatPemeriksaan,
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
                          controller: kontrolSelanjutnya,
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
                          controller: catatanTambahan,
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
            FutureBuilder(
              future: ConstantHelper.isPatient(),
              builder: (context, snapshot) => snapshot.data == true
                  ? SizedBox()
                  : Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      child: BaseButton(
                        style: AppButtonStyle.primary,
                        radius: 8,
                        padding: 16,
                        text: "Simpan Informasi",
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            onSaveData();
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
            ),
          ],
        ),
      ),
    );
  }
}
