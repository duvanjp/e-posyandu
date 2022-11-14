part of '../pages.dart';

class MaternityDetailPage extends StatelessWidget {
  final Maternity maternity;
  const MaternityDetailPage({Key? key, required this.maternity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "${maternity.tanggalBersalin}",
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
              "Detail Data Ibu Bersalin",
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
              title: "Tanggal Bersalin", text: maternity.tanggalBersalin),
          TextItemWidget(
              title: "Umur Kehamilan", text: maternity.umurKehamilan),
          TextItemWidget(
              title: "Penolongan Bersalin",
              text: maternity.penolonganPersalinan),
          TextItemWidget(title: "Keadaan Ibu", text: maternity.keadaanIbu),
          TextItemWidget(
              title: "Catatan Tambahan", text: maternity.catatanTambahan),
        ],
      ),
    );
  }
}
