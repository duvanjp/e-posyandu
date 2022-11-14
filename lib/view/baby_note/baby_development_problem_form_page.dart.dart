part of '../pages.dart';

class BabyDevelopmentProblemFormPage extends StatefulWidget {
  final List<Baby> baby;
  final Patient patient;
  BabyDevelopmentProblemFormPage(
      {Key? key, required this.baby, required this.patient})
      : super(key: key);

  @override
  _BabyDevelopmentProblemFormPageState createState() =>
      _BabyDevelopmentProblemFormPageState();
}

class _BabyDevelopmentProblemFormPageState
    extends State<BabyDevelopmentProblemFormPage> {
  late PatientCubit patientCubit;
  List<DropdownMenuItem<Baby>> listBabyMenu = [];
  late Baby selectedBaby;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController permasalahanAnak = TextEditingController();
  TextEditingController tanggalPemeriksaan = TextEditingController();
  TextEditingController tindakan = TextEditingController();
  TextEditingController namaPemeriksa = TextEditingController();
  TextEditingController catatanTambahan = TextEditingController();

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

  @override
  void dispose() {
    permasalahanAnak.dispose();
    tanggalPemeriksaan.dispose();
    tindakan.dispose();
    namaPemeriksa.dispose();
    catatanTambahan.dispose();
    super.dispose();
  }

  onSaveData() {
    AppAlertDialog(
        title: 'Konfirmasi',
        description: 'Apakah data yang anda berikan sudah benar?',
        positiveButtonText: 'Ya',
        positiveButtonOnTap: () {
          DevelopmentProblem developmentProblem = DevelopmentProblem(
              namaAnak: selectedBaby.namaAnak,
              catatan: catatanTambahan.text,
              namaPemeriksa: namaPemeriksa.text,
              permasalahan: permasalahanAnak.text,
              tanggalPemeriksaan: tanggalPemeriksaan.text,
              tindakan: tindakan.text);
          patientCubit.saveDevProblemData(
              widget.patient.referenceId, developmentProblem);
        },
        negativeButtonText: 'Tidak',
        negativeButtonOnTap: () => Navigator.pop(context)).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is DevelopmentProblemSaveLoading) {
          progressDialogFull(context);
        } else if (state is DevelopmentProblemSaveSuccess) {
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
            "Masalah Perkembangan",
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
                          label: "Permasalahan",
                          isRequired: true,
                          controller: permasalahanAnak,
                          hint: "e.g anak demam tinggi",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Permasalahan Masih Kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Tanggal Pemeriksaan",
                          isRequired: true,
                          controller: tanggalPemeriksaan,
                          hint: "e.g 12 januari 2020",
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Tanggal Pemeriksaan masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Tindakan",
                          isRequired: true,
                          controller: tindakan,
                          hint: "e.g Diberi Obat Antibiotik",
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Taindakan masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Nama Pemeriksa",
                          isRequired: true,
                          controller: namaPemeriksa,
                          hint: "e.g Bidan Dewi",
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Nama Pemeriksa masih kosong";
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
          ],
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
      ),
    );
  }
}
