part of '../pages.dart';

class PatientDetailPage extends StatefulWidget {
  final Patient patient;
  const PatientDetailPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "${widget.patient.namaIbu}",
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Detail Data Akun",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(),
                  ),
                  TextItemWidget(
                      title: "Username", text: widget.patient.username),
                  TextItemWidget(
                      title: "Kata Sandi",
                      text: widget.patient.password,
                      isPass: true),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Detail Data Akun",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(),
                  ),
                  TextItemWidget(
                      title: "Nama Ibu", text: widget.patient.namaIbu),
                  TextItemWidget(
                      title: "Tempat/Tanggal Lahir Ibu",
                      text: widget.patient.ttlIbu),
                  TextItemWidget(
                      title: "Agama Ibu", text: widget.patient.agamaIbu),
                  TextItemWidget(
                      title: "Pendidikan Ibu",
                      text: widget.patient.pendidikanIbu),
                  TextItemWidget(
                      title: "Golongan Darah",
                      text: widget.patient.goldarahIbu),
                  TextItemWidget(
                      title: "Pekerjaan Ibu",
                      text: widget.patient.pekerjaanIbu),
                  TextItemWidget(
                      title: "Nama Suami", text: widget.patient.namaSuami),
                  TextItemWidget(
                      title: "Tempat/Tanggal Lahir Suami",
                      text: widget.patient.ttlSuami),
                  TextItemWidget(
                      title: "Agama Suami", text: widget.patient.agamaSuami),
                  TextItemWidget(
                      title: "Pendidikan Suami",
                      text: widget.patient.pendidikanSuami),
                  TextItemWidget(
                      title: "Pekerjaan Suami",
                      text: widget.patient.pekerjaanSuami),
                  TextItemWidget(
                      title: "Alamat Rumah", text: widget.patient.alamatRumah),
                  TextItemWidget(
                      title: "Nomor Hp Ibu", text: widget.patient.noTelp),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          FutureBuilder(
              future: ConstantHelper.isPatient(),
              builder: ((context, snapshot) => snapshot.data == true
                  ? SizedBox()
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(height: 0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Kartu NFC",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              BaseButton(
                                style: AppButtonStyle.secondary,
                                radius: 8,
                                text: "Buat Kartu",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateNfcPage(
                                              patient: widget.patient,
                                              isFromDetailPatient: true)));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
            child: BaseButton(
              style: AppButtonStyle.primary,
              radius: 8,
              padding: 16,
              text: "Edit Data",
              onPressed: () {
                print(widget.patient.referenceId);
                print(widget.patient.toJson());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RegisterPage(patient: widget.patient)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
