part of '../pages.dart';

class PregnantDetailPage extends StatelessWidget {
  final Pregnant pregnant;
  const PregnantDetailPage({Key? key, required this.pregnant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "${pregnant.tanggalPengecekan}",
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
              "Detail Catatan Ibu Hamil",
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
              title: "Keluhan Sekarang", text: pregnant.keluhanSekarang),
          TextItemWidget(title: "Tekanan Darah", text: pregnant.tekananDarah),
          TextItemWidget(title: "Berat Badan", text: pregnant.beratBadan),
          TextItemWidget(
              title: "Umur Kehamilan (Minggu)", text: pregnant.umurKehamilan),
          TextItemWidget(
              title: "Tinggi Fundus (cm)", text: pregnant.tinggiFundus),
          TextItemWidget(title: "Letak Janin", text: pregnant.letakJanin),
          TextItemWidget(
              title: "Denyut Jantung Janin/Menit",
              text: pregnant.denyutJantungJanin),
          TextItemWidget(title: "Kaki Bengkak", text: pregnant.kakiBengkak),
          TextItemWidget(
              title: "Hasil Laboratorium", text: pregnant.hasilLaboratorium),
          TextItemWidget(title: "Tindakan", text: pregnant.tindakan),
          TextItemWidget(
              title: "Tempat Pemeriksaan", text: pregnant.tempatPemeriksaan),
          TextItemWidget(
              title: "Kontrol Selanjutnya", text: pregnant.kontrolSelanjutnya),
          TextItemWidget(
              title: "catatan Tambahan", text: pregnant.catatanTambahan),
        ],
      ),
    );
  }
}
