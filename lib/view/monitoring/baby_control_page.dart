part of '../pages.dart';

class BabyContolPage extends StatefulWidget {
  final Patient patient;
  BabyContolPage({Key? key, required this.patient}) : super(key: key);

  @override
  _BabyContolPageState createState() => _BabyContolPageState();
}

class _BabyContolPageState extends State<BabyContolPage> {
  late PatientCubit patientCubit;
  bool isLoading = true;

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    patientCubit.getBabyControlData(widget.patient.referenceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is BabyControlLoaded) {
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
                    builder: (context) => BabyContolFormPage(
                          baby: patientCubit.listBaby,
                          patient: widget.patient,
                        )));
          }
        }
      },
      child: Scaffold(
        body: Container(
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
                      : patientCubit.listBabyControl.length == 0
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
                              itemCount: patientCubit.listBabyControl.length,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              itemBuilder: (context, index) {
                                final babyControl =
                                    patientCubit.listBabyControl[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BabyControlDetailPage(
                                                    babyControl: babyControl)));
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
                                          babyControl.namaAnak,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          babyControl.tanggalKontrol +
                                              " - " +
                                              babyControl.keluhan,
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
                        ))),
            ],
          ),
        ),
      ),
    );
  }
}
