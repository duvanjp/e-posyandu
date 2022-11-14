part of '../pages.dart';

class PostpartumFormPage extends StatefulWidget {
  final Patient patient;
  PostpartumFormPage({Key? key, required this.patient}) : super(key: key);

  @override
  _PostpartumFormPageState createState() => _PostpartumFormPageState();
}

class _PostpartumFormPageState extends State<PostpartumFormPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late PatientCubit patientCubit;
  TextEditingController keluhanSekarang = TextEditingController();
  TextEditingController tekananDarah = TextEditingController();
  TextEditingController beratBadan = TextEditingController();
  TextEditingController denyutJantung = TextEditingController();
  TextEditingController kakiBengkak = TextEditingController();
  TextEditingController hasilLab = TextEditingController();
  TextEditingController tindakan = TextEditingController();
  TextEditingController tempatPemeriksaan = TextEditingController();
  TextEditingController kontrolSelanjutnya = TextEditingController();
  TextEditingController catatanTambahan = TextEditingController();
  late String dateNow;

  @override
  void initState() {
    final date = DateFormat.yMMMMEEEEd('id_ID');
    dateNow = date.format(DateTime.now());
    patientCubit = BlocProvider.of<PatientCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    keluhanSekarang.dispose();
    tekananDarah.dispose();
    beratBadan.dispose();
    denyutJantung.dispose();
    kakiBengkak.dispose();
    hasilLab.dispose();
    tindakan.dispose();
    tempatPemeriksaan.dispose();
    kontrolSelanjutnya.dispose();
    catatanTambahan.dispose();
    super.dispose();
  }

  onSaveData() {
    AppAlertDialog(
        title: 'Konfirmasi',
        description: 'Apakah data yang anda berikan sudah benar?',
        positiveButtonText: 'Ya',
        positiveButtonOnTap: () {
          Postpartum postpartum = Postpartum(
              tanggalPengecekan: dateNow,
              keluhanSekarang: keluhanSekarang.text,
              tekananDarah: tekananDarah.text,
              beratBadan: beratBadan.text,
              denyutJantung: denyutJantung.text,
              kakiBengkak: kakiBengkak.text,
              hasilLab: hasilLab.text,
              tindakan: tindakan.text,
              tempatPemeriksaan: tempatPemeriksaan.text,
              kontrolSelanjutnya: kontrolSelanjutnya.text,
              catatanTambahan: catatanTambahan.text);
          patientCubit.savePostpartumData(
              widget.patient.referenceId, postpartum);
        },
        negativeButtonText: 'Tidak',
        negativeButtonOnTap: () => Navigator.pop(context)).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is PostpartumSaveLoading) {
          progressDialogFull(context);
        } else if (state is PostpartumSaveSuccess) {
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
            "Kesehatan Ibu Nifas",
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
                          label: "Denyut Jantung / Menit",
                          hint: " ",
                          controller: denyutJantung,
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
                builder: ((context, snapshot) => snapshot.data == true
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
                            }),
                      )))
          ],
        ),
      ),
    );
  }
}
