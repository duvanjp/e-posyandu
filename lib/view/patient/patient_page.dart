part of '../pages.dart';

class PatientPage extends StatefulWidget {
  PatientPage({Key? key}) : super(key: key);

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  late PatientCubit patientCubit;
  bool isLoading = true;

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    patientCubit.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is PatientLoaded) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: const Text(
            "Daftar Pasien",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 1,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
              ),
            ),
            Expanded(
              child: Container(
                color: AppColor.grey,
                child: isLoading
                    ? Center(
                        child:
                            CircularProgressIndicator(color: AppColor.primary),
                      )
                    : patientCubit.listPatient.length == 0
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
                            itemCount: patientCubit.listPatient.length,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            itemBuilder: (context, index) {
                              final dataPatient =
                                  patientCubit.listPatient[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: PatientItemWidget(
                                    dataPatient: dataPatient,
                                    onTap: () {
                                      print(dataPatient.referenceId);
                                      print(dataPatient.toJson());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  CatatanPage(
                                                      patient: dataPatient)));
                                    }),
                              );
                            },
                          ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: BaseButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ));
                },
                text: "Tambah Pasien",
                radius: 8,
                padding: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
