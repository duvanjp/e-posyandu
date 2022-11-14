part of '../pages.dart';

class BabyDetailPage extends StatelessWidget {
  final Baby baby;
  const BabyDetailPage({Key? key, required this.baby}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "${baby.namaAnak}",
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
              "Detail Data Anak",
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
          TextItemWidget(title: "Status", text: baby.statusAnak),
          TextItemWidget(title: "Nama", text: baby.namaAnak),
          TextItemWidget(title: "Tanggal Lahir", text: baby.tgllhrAnak),
          TextItemWidget(title: "Berat Lahir", text: baby.beratAnak),
          TextItemWidget(title: "Panjang Badan", text: baby.panjangAnak),
          TextItemWidget(title: "Linkar Kepala", text: baby.lingkarkepalaAnak),
          TextItemWidget(title: "Jenis Kelamin", text: baby.kelaminAnak),
          TextItemWidget(title: "Catatan Tambahan", text: baby.catatanAnak),
        ],
      ),
    );
  }
}
