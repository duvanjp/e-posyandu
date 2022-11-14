part of '../pages.dart';

class ImmunizationPage extends StatefulWidget {
  final Patient patient;
  ImmunizationPage({Key? key, required this.patient}) : super(key: key);

  @override
  _ImmunizationPageState createState() => _ImmunizationPageState();
}

class _ImmunizationPageState extends State<ImmunizationPage> {
  late PatientCubit patientCubit;
  bool isLoading = true;

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    patientCubit.getImmunizationData(widget.patient.referenceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PatientCubit, PatientState>(
        listener: (context, state) {
          if (state is ImmunizationLoaded) {
            setState(() {
              isLoading = false;
            });
          } else if (state is BabyLoadLoading) {
            progressDialogFull(context);
          } else if (state is BabyLoaded) {
            dismissProgressDialogFull(context);
            if (patientCubit.listBaby.length == 0) {
              AppAlertDialog(
                  title: 'Pesan',
                  description:
                      'Pasien belum memiliki bayi yang terdaftar! Silahkan mendaftarkan bayi terlebih dahulu pada menu Catatan Bayi Baru Lahir.',
                  negativeButtonText: 'Tutup',
                  negativeButtonOnTap: () =>
                      Navigator.pop(context)).show(context);
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImmunizationFormPage(
                          baby: patientCubit.listBaby,
                          patient: widget.patient)));
            }
          }
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColor.grey,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: AppColor.primary),
                        )
                      : patientCubit.listImmunization.length == 0
                          ? Center(
                              child: Text(
                                "Data Kosong",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.black,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: patientCubit.listImmunization.length,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              itemBuilder: (context, index) {
                                final immunization =
                                    patientCubit.listImmunization[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BabyNoteDetailPage(
                                                    developmentProblem:
                                                        DevelopmentProblem(
                                                            namaAnak: "",
                                                            catatan: "",
                                                            namaPemeriksa: "",
                                                            permasalahan: "",
                                                            tanggalPemeriksaan:
                                                                "",
                                                            tindakan: ""),
                                                    immunization:
                                                        immunization)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColor.boxGrey,
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                              offset: Offset(0, 0))
                                        ]),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          immunization.jenisImmunization,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          immunization.namaAnak,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ),
              FutureBuilder(
                  future: ConstantHelper.isPatient(),
                  builder: ((context, snapshot) => snapshot.data == true
                      ? SizedBox()
                      : Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          child: BaseButton(
                            onPressed: () {
                              patientCubit.loadBabyData(widget.patient);
                            },
                            text: "Tambah Catatan",
                            radius: 8,
                            padding: 15,
                          ),
                        )))
            ],
          ),
        ),
      ),
    );
  }
}
