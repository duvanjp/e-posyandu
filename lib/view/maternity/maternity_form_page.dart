part of '../pages.dart';

class MaternityFormPage extends StatefulWidget {
  final Patient patient;
  MaternityFormPage({Key? key, required this.patient}) : super(key: key);

  @override
  _MaternityFormPageState createState() => _MaternityFormPageState();
}

class _MaternityFormPageState extends State<MaternityFormPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late PatientCubit patientCubit;
  TextEditingController tanggalBersalin = TextEditingController();
  TextEditingController umurKehamilan = TextEditingController();
  TextEditingController penolonganPersalinan = TextEditingController();
  TextEditingController keadaanIbu = TextEditingController();
  TextEditingController catatanTambahan = TextEditingController();

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    tanggalBersalin.dispose();
    umurKehamilan.dispose();
    penolonganPersalinan.dispose();
    keadaanIbu.dispose();
    catatanTambahan.dispose();
    super.dispose();
  }

  onSaveData() {
    AppAlertDialog(
        title: 'Konfirmasi',
        description: 'Apakah data yang anda berikan sudah benar?',
        positiveButtonText: 'Ya',
        positiveButtonOnTap: () {
          Maternity maternity = Maternity(
            catatanTambahan:
                catatanTambahan.text.isEmpty ? "" : catatanTambahan.text,
            keadaanIbu: keadaanIbu.text,
            penolonganPersalinan: penolonganPersalinan.text.isEmpty
                ? ""
                : penolonganPersalinan.text,
            tanggalBersalin: tanggalBersalin.text,
            umurKehamilan: umurKehamilan.text,
          );
          patientCubit.saveMaternityData(widget.patient.referenceId, maternity);
        },
        negativeButtonText: 'Tidak',
        negativeButtonOnTap: () => Navigator.pop(context)).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is MaternityNotesSaveLoading) {
          progressDialogFull(context);
        } else if (state is MaternityNotesSaveSuccess) {
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
            "Kesehatan Ibu Bersalin",
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
                        AddInput(
                          label: "Tanggal Beraslin",
                          isRequired: true,
                          controller: tanggalBersalin,
                          type: TextInputType.name,
                          hint: "e.g 12 Januari",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Tanggal Bersalin masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Umur Kehamilan",
                          isRequired: true,
                          controller: umurKehamilan,
                          hint: "e.g 8 Bulan",
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Umur Kehamilan masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Penolongan Persalinan",
                          controller: penolonganPersalinan,
                          hint: "80 Kg",
                          validation: (value) {
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Keadaan Ibu",
                          isRequired: true,
                          controller: keadaanIbu,
                          hint: "Sehat",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Keadaan Ibu masih kosong";
                            }
                            return null;
                          },
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
