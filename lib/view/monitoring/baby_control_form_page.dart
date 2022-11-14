part of '../pages.dart';

class BabyContolFormPage extends StatefulWidget {
  final List<Baby> baby;
  final Patient patient;
  BabyContolFormPage({
    Key? key,
    required this.baby,
    required this.patient,
  }) : super(key: key);

  @override
  _BabyContolFormPageState createState() => _BabyContolFormPageState();
}

class _BabyContolFormPageState extends State<BabyContolFormPage> {
  late PatientCubit patientCubit;
  List<DropdownMenuItem<Baby>> listBabyMenu = [];
  late Baby selectedBaby;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController umur = TextEditingController();
  TextEditingController beratBadan = TextEditingController();
  TextEditingController tinggiBadan = TextEditingController();
  TextEditingController keluhan = TextEditingController();
  TextEditingController frekNafas = TextEditingController();
  TextEditingController frekDenyut = TextEditingController();
  TextEditingController pemeriksaaanDiare = TextEditingController();
  TextEditingController pemeriksaaanIkterus = TextEditingController();
  TextEditingController statusImunisasi = TextEditingController();
  TextEditingController keluhanLain = TextEditingController();
  TextEditingController tindakan = TextEditingController();
  TextEditingController namaPemeriksa = TextEditingController();

  late String dateNow;

  @override
  void dispose() {
    umur.dispose();
    beratBadan.dispose();
    tinggiBadan.dispose();
    keluhan.dispose();
    frekNafas.dispose();
    frekDenyut.dispose();
    pemeriksaaanDiare.dispose();
    pemeriksaaanIkterus.dispose();
    statusImunisasi.dispose();
    keluhanLain.dispose();
    tindakan.dispose();
    namaPemeriksa.dispose();
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

    initializeDateFormatting();
    final DateFormat date = DateFormat.yMMMMEEEEd('id_ID');
    dateNow = date.format(DateTime.now());
    super.initState();
  }

  onSaveData() {
    AppAlertDialog(
        title: 'Konfirmasi',
        description: 'Apakah data yang anda berikan sudah benar?',
        positiveButtonText: 'Ya',
        positiveButtonOnTap: () {
          double umurBayi = double.parse(umur.text);
          double beratBayi = double.parse(beratBadan.text);
          BabyControl babyControl = BabyControl(
            namaAnak: selectedBaby.namaAnak,
            umur: umurBayi,
            beratBadan: beratBayi,
            tinggiBadan: tinggiBadan.text,
            keluhan: keluhan.text,
            frekNafas: frekNafas.text,
            frekJantung: frekDenyut.text,
            diare: pemeriksaaanDiare.text,
            ikterus: pemeriksaaanIkterus.text,
            statusImunisasi: statusImunisasi.text,
            keluhanLain: keluhanLain.text,
            tindakanIbu: tindakan.text,
            namaPemeriksa: namaPemeriksa.text,
            tanggalKontrol: dateNow,
          );

          patientCubit.saveBabyControlData(
              widget.patient.referenceId, babyControl);
        },
        negativeButtonText: 'Tidak',
        negativeButtonOnTap: () => Navigator.pop(context)).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is BabyControlSaveLoading) {
          progressDialogFull(context);
        } else if (state is BabyControlSaveSuccess) {
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
            "Kontrol Anak",
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
                          label: "Umur",
                          isRequired: true,
                          controller: umur,
                          hint: "e.g 2.5",
                          suffixText: "Bulan",
                          type: TextInputType.number,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Berat Badan Masih Kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Berat Badan",
                          isRequired: true,
                          type: TextInputType.number,
                          controller: beratBadan,
                          hint: "e.g 3",
                          suffixText: "Kg",
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
                          controller: tinggiBadan,
                          hint: "e.g 50 cm",
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
                          controller: keluhan,
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
                          controller: frekNafas,
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
                          controller: frekDenyut,
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
                          controller: pemeriksaaanDiare,
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
                          controller: pemeriksaaanIkterus,
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
                          controller: statusImunisasi,
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
                          controller: keluhanLain,
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
                          controller: tindakan,
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
                          controller: namaPemeriksa,
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
