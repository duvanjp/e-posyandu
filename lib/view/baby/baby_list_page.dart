part of '../pages.dart';

class BabyListPage extends StatefulWidget {
  final Patient patient;
  BabyListPage({Key? key, required this.patient}) : super(key: key);

  @override
  _BabyListPageState createState() => _BabyListPageState();
}

class _BabyListPageState extends State<BabyListPage> {
  late PatientCubit patientCubit;
  bool isLoading = true;
  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    patientCubit.loadBabyData(widget.patient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Daftar Bayi Baru Lahir",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        elevation: 1,
      ),
      body: BlocListener<PatientCubit, PatientState>(
        listener: (context, state) {
          if (state is BabyLoaded) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Column(
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
                    : patientCubit.listBaby.length == 0
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
                            itemCount: patientCubit.listBaby.length,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            itemBuilder: (context, index) {
                              final dataBaby = patientCubit.listBaby[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BabyDetailPage(baby: dataBaby)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.boxGrey,
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 0))
                                      ]),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dataBaby.namaAnak,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    dataBaby.tgllhrAnak,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: AppColor.greyFont,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
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
                        padding: const EdgeInsets.all(15),
                        child: BaseButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BabyRegisPage(
                                        patient: widget.patient)));
                          },
                          text: "Tambah Catatan Bayi Baru Lahir",
                          radius: 8,
                          padding: 16,
                        ),
                      )))
          ],
        ),
      ),
    );
  }
}
