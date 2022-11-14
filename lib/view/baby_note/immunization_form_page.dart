part of '../pages.dart';

class ImmunizationFormPage extends StatefulWidget {
  final List<Baby> baby;
  final Patient patient;
  ImmunizationFormPage({Key? key, required this.baby, required this.patient})
      : super(key: key);

  @override
  _ImmunizationFormPageState createState() => _ImmunizationFormPageState();
}

class _ImmunizationFormPageState extends State<ImmunizationFormPage> {
  late PatientCubit patientCubit;
  List<DropdownMenuItem<Baby>> listBabyMenu = [];
  late Baby selectedBaby;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController jenisImunisasi = TextEditingController();
  TextEditingController tanggalImunisasi = TextEditingController();
  TextEditingController catatanTambahan = TextEditingController();
  TextEditingController namaPetugas = TextEditingController();

  @override
  void dispose() {
    jenisImunisasi.dispose();
    tanggalImunisasi.dispose();
    catatanTambahan.dispose();
    namaPetugas.dispose();
    super.dispose();
  }

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    for (var i = 0; i < widget.baby.length; i++) {
      final baby = widget.baby[i];
      listBabyMenu.add(DropdownMenuItem(
        value: baby,
        child: Text(baby.namaAnak),
      ));
    }
    selectedBaby = widget.baby[0];
    super.initState();
  }

  onSaveData() {
    AppAlertDialog(
        title: 'Konfirmasi',
        description: 'Apakah data yang anda berikan sudah benar?',
        positiveButtonText: 'Ya',
        positiveButtonOnTap: () {
          Immunization dataImmunization = Immunization(
              namaAnak: selectedBaby.namaAnak,
              catatan:
                  catatanTambahan.text.isEmpty ? "-" : catatanTambahan.text,
              jenisImmunization: jenisImunisasi.text,
              tglImmunization: tanggalImunisasi.text,
              namaPetugas: namaPetugas.text);
          patientCubit.saveImmunizationData(
              widget.patient.referenceId, dataImmunization);
        },
        negativeButtonText: 'Tidak',
        negativeButtonOnTap: () => Navigator.pop(context)).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is ImmunizationSaveLoading) {
          progressDialogFull(context);
        } else if (state is ImmunizationSaveSuccess) {
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
            "Imunisasi",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          elevation: 1,
        ),
        body: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Anak",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                  DropdownButtonFormField<Baby>(
                    items: listBabyMenu,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 14,
                    ),
                    isExpanded: true,
                    value: widget.baby[0],
                    onChanged: (value) {
                      setState(() {
                        selectedBaby = value!;
                      });
                      print(selectedBaby.namaAnak);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formkey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    child: Column(
                      children: [
                        AddInput(
                          label: "Jenis Imunisasi",
                          isRequired: true,
                          controller: jenisImunisasi,
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
                          controller: tanggalImunisasi,
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
                          controller: catatanTambahan,
                          type: TextInputType.name,
                          validation: (value) {
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Nama Petugas",
                          isRequired: true,
                          hint: "e.g Suyadi",
                          controller: namaPetugas,
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Nama Petugas masih kosong";
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
