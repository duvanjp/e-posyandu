part of '../pages.dart';

class BabyControlDetailPage extends StatelessWidget {
  final BabyControl babyControl;
  const BabyControlDetailPage({Key? key, required this.babyControl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: Text(
            babyControl.namaAnak,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          elevation: 1,
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Detail Data Kontrol Anak",
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
            TextItemWidget(title: "Umur", text: babyControl.umur.toString()),
            TextItemWidget(
                title: "Berat Badan", text: babyControl.beratBadan.toString()),
            TextItemWidget(
                title: "Tinggi Badan", text: babyControl.tinggiBadan),
            TextItemWidget(
                title: "Keluhan Penyakit", text: babyControl.keluhan),
            TextItemWidget(
                title: "Frekuensi Nafas", text: babyControl.frekNafas),
            TextItemWidget(
                title: "Frekuensi Denyut Jantung",
                text: babyControl.frekJantung),
            TextItemWidget(title: "Pemeriksaan Diare", text: babyControl.diare),
            TextItemWidget(
                title: "Pemeriksaan Ikterus", text: babyControl.ikterus),
            TextItemWidget(
                title: "Status Imunisasi", text: babyControl.statusImunisasi),
            TextItemWidget(
                title: "keluhan Lain", text: babyControl.keluhanLain),
            TextItemWidget(title: "Tindakan", text: babyControl.tindakanIbu),
            TextItemWidget(
                title: "Nama Pemeriksa", text: babyControl.namaPemeriksa),
          ],
        ));
  }
}
