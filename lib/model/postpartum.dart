part of 'models.dart';

Postpartum postpartumFromJson(String str) =>
    Postpartum.fromJson(json.decode(str));

String postpartumToJson(Postpartum data) => json.encode(data.toJson());

class Postpartum {
  Postpartum({
    this.referenceId,
    required this.tanggalPengecekan,
    required this.keluhanSekarang,
    required this.tekananDarah,
    required this.beratBadan,
    required this.denyutJantung,
    required this.kakiBengkak,
    required this.hasilLab,
    required this.tindakan,
    required this.tempatPemeriksaan,
    required this.kontrolSelanjutnya,
    required this.catatanTambahan,
  });

  String? referenceId;
  String tanggalPengecekan;
  String keluhanSekarang;
  String tekananDarah;
  String beratBadan;
  String denyutJantung;
  String kakiBengkak;
  String hasilLab;
  String tindakan;
  String tempatPemeriksaan;
  String kontrolSelanjutnya;
  String catatanTambahan;

  factory Postpartum.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Postpartum.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory Postpartum.fromJson(Map<String, dynamic> json) => Postpartum(
        tanggalPengecekan: json["tanggal_pengecekan"],
        keluhanSekarang: json["keluhan_sekarang"],
        tekananDarah: json["tekanan_darah"],
        beratBadan: json["berat_badan"],
        denyutJantung: json["denyut_jantung"],
        kakiBengkak: json["kaki_bengkak"],
        hasilLab: json["hasil_lab"],
        tindakan: json["tindakan"],
        tempatPemeriksaan: json["tempat_pemeriksaan"],
        kontrolSelanjutnya: json["kontrol_selanjutnya"],
        catatanTambahan: json["catatan_tambahan"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_pengecekan": tanggalPengecekan,
        "keluhan_sekarang": keluhanSekarang,
        "tekanan_darah": tekananDarah,
        "berat_badan": beratBadan,
        "denyut_jantung": denyutJantung,
        "kaki_bengkak": kakiBengkak,
        "hasil_lab": hasilLab,
        "tindakan": tindakan,
        "tempat_pemeriksaan": tempatPemeriksaan,
        "kontrol_selanjutnya": kontrolSelanjutnya,
        "catatan_tambahan": catatanTambahan,
      };
}
