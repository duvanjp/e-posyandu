part of "models.dart";

Pregnant pregnantFromJson(String str) => Pregnant.fromJson(json.decode(str));

String pregnantToJson(Pregnant data) => json.encode(data.toJson());

class Pregnant {
  Pregnant({
    this.referenceId,
    required this.tanggalPengecekan,
    required this.keluhanSekarang,
    required this.tekananDarah,
    required this.beratBadan,
    required this.umurKehamilan,
    required this.tinggiFundus,
    required this.letakJanin,
    required this.denyutJantungJanin,
    required this.kakiBengkak,
    required this.hasilLaboratorium,
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
  String umurKehamilan;
  String tinggiFundus;
  String letakJanin;
  String denyutJantungJanin;
  String kakiBengkak;
  String hasilLaboratorium;
  String tindakan;
  String tempatPemeriksaan;
  String kontrolSelanjutnya;
  String catatanTambahan;

  factory Pregnant.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Pregnant.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory Pregnant.fromJson(Map<String, dynamic> json) => Pregnant(
        tanggalPengecekan: json["tanggal_pengecekan"],
        keluhanSekarang: json["keluhan_sekarang"],
        tekananDarah: json["tekanan_darah"],
        beratBadan: json["berat_badan"],
        umurKehamilan: json["umur_kehamilan"],
        tinggiFundus: json["tinggi_fundus"],
        letakJanin: json["letak_janin"],
        denyutJantungJanin: json["denyut_jantung_janin"],
        kakiBengkak: json["kaki_bengkak"],
        hasilLaboratorium: json["hasil_laboratorium"],
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
        "umur_kehamilan": umurKehamilan,
        "tinggi_fundus": tinggiFundus,
        "letak_janin": letakJanin,
        "denyut_jantung_janin": denyutJantungJanin,
        "kaki_bengkak": kakiBengkak,
        "hasil_laboratorium": hasilLaboratorium,
        "tindakan": tindakan,
        "tempat_pemeriksaan": tempatPemeriksaan,
        "kontrol_selanjutnya": kontrolSelanjutnya,
        "catatan_tambahan": catatanTambahan,
      };
}
