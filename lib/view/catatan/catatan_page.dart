part of '../pages.dart';

class CatatanPage extends StatefulWidget {
  final Patient patient;
  final bool isAdmin;
  const CatatanPage({
    Key? key,
    required this.patient,
    this.isAdmin = true,
  }) : super(key: key);

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  late PatientCubit patientCubit;

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Catatan Kesehatan",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: AppColor.primary,
          elevation: 1,
          actions: widget.isAdmin
              ? null
              : [
                  IconButton(
                    onPressed: () {
                      AppAlertDialog(
                          title: 'Keluar',
                          description:
                              'Apakah anda yakin ingin keluar dari akun ini ?',
                          positiveButtonText: 'Ya',
                          positiveButtonOnTap: () {
                            patientCubit.logOut();
                          },
                          negativeButtonText: 'Tidak',
                          negativeButtonOnTap: () =>
                              Navigator.pop(context)).show(context);
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
        ),
        body: BlocListener<PatientCubit, PatientState>(
          listener: (context, state) {
            if (state is PatientLoading) {
              progressDialogFull(context);
            } else if (state is PatientLoggedOut) {
              GlobalHelper().toWelcomePage(context);
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                PatientItemWidget(
                  dataPatient: widget.patient,
                  isNavigate: false,
                  onTap: () {
                    print(widget.patient.referenceId);
                    print(widget.patient.toJson());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PatientDetailPage(patient: widget.patient)));
                  },
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0,
                            color: AppColor.boxGrey,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Menu(
                            name: "Catatan Ibu Hamil",
                            icon: Icons.pregnant_woman_outlined,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PregnantPage(
                                          patient: widget.patient)));
                            },
                          ),
                          Menu(
                            name: "Catatan Ibu Bersalin",
                            icon: Icons.local_hospital_outlined,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MaternityPage(
                                          patient: widget.patient)));
                            },
                          ),
                          Menu(
                            name: "Catatan Bayi Baru Lahir",
                            icon: Icons.child_friendly_outlined,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BabyListPage(
                                          patient: widget.patient)));
                            },
                          ),
                          Menu(
                            name: "Catatan Ibu Nifas",
                            icon: Icons.list,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostpartumPage(
                                          patient: widget.patient)));
                            },
                          ),
                          Menu(
                            name: "Catatan Anak",
                            icon: Icons.child_care,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BabyNotePage(
                                          patient: widget.patient)));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 15.0),
                  child: BaseButton(
                    style: AppButtonStyle.primary,
                    radius: 8,
                    padding: 16,
                    text: "Monitoring Anak",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MonitoringPage(patient: widget.patient)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
