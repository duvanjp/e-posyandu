part of '../pages.dart';

class PostpartumDetailPage extends StatelessWidget {
  final Postpartum postpartum;
  const PostpartumDetailPage({Key? key, required this.postpartum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "${postpartum.tanggalPengecekan}",
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
              "Detail Catatan Ibu Nifas",
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
              title: "Keluhan Sekarang", text: postpartum.keluhanSekarang),
          TextItemWidget(title: "Tekanan Darah", text: postpartum.tekananDarah),
          TextItemWidget(title: "Berat Badan", text: postpartum.beratBadan),
          TextItemWidget(
              title: "Denyut Jantung/Menit", text: postpartum.denyutJantung),
          TextItemWidget(title: "Kaki Bengkak", text: postpartum.kakiBengkak),
          TextItemWidget(
              title: "Hasil Laboratorium", text: postpartum.hasilLab),
          TextItemWidget(title: "Tindakan", text: postpartum.tindakan),
          TextItemWidget(
              title: "Tempat Pemeriksaan", text: postpartum.tempatPemeriksaan),
          TextItemWidget(
              title: "Kontrol Selanjutnya",
              text: postpartum.kontrolSelanjutnya),
          TextItemWidget(
              title: "Catatan Tambahan", text: postpartum.catatanTambahan),
        ],
      ),
    );
  }
}
