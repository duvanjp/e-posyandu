part of '../pages.dart';

class BabyNoteDetailPage extends StatelessWidget {
  final Immunization immunization;
  final DevelopmentProblem developmentProblem;
  const BabyNoteDetailPage(
      {Key? key, required this.immunization, required this.developmentProblem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImmunization = immunization.namaAnak != "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          isImmunization ? immunization.namaAnak : developmentProblem.namaAnak,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: isImmunization ? immunizationData() : devProblemData(),
    );
  }

  Column immunizationData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "Detail Data Imunisasi",
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
        TextItemWidget(title: "Nama", text: immunization.namaAnak),
        TextItemWidget(
            title: "Jenis Imunisasi", text: immunization.jenisImmunization),
        TextItemWidget(
            title: "Tanggal Imunisasi", text: immunization.tglImmunization),
        TextItemWidget(title: "Catatan Tambahan", text: immunization.catatan),
        TextItemWidget(title: "Nama Petugas", text: immunization.namaPetugas),
      ],
    );
  }

  Column devProblemData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "Detail Data Masalah Perkembangan",
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
        TextItemWidget(title: "Nama", text: developmentProblem.namaAnak),
        TextItemWidget(
            title: "Permasalahan", text: developmentProblem.permasalahan),
        TextItemWidget(
            title: "Tanggal Pemeriksaan",
            text: developmentProblem.tanggalPemeriksaan),
        TextItemWidget(title: "Tindakan", text: developmentProblem.tindakan),
        TextItemWidget(
            title: "Nama Pemeriksa", text: developmentProblem.namaPemeriksa),
        TextItemWidget(
            title: "Catatan Tambahan", text: developmentProblem.catatan),
      ],
    );
  }
}
