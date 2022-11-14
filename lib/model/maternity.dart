part of 'models.dart';

Maternity maternityFromJson(String str) => Maternity.fromJson(json.decode(str));

String maternityToJson(Maternity data) => json.encode(data.toJson());

class Maternity {
  Maternity({
    this.referenceId,
    required this.tanggalBersalin,
    required this.umurKehamilan,
    required this.penolonganPersalinan,
    required this.keadaanIbu,
    required this.catatanTambahan,
  });

  String? referenceId;
  String tanggalBersalin;
  String umurKehamilan;
  String penolonganPersalinan;
  String keadaanIbu;
  String catatanTambahan;

  factory Maternity.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Maternity.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory Maternity.fromJson(Map<String, dynamic> json) => Maternity(
        tanggalBersalin: json["tanggal_bersalin"],
        umurKehamilan: json["umur_kehamilan"],
        penolonganPersalinan: json["penolongan_persalinan"],
        keadaanIbu: json["keadaan_ibu"],
        catatanTambahan: json["catatan_tambahan"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_bersalin": tanggalBersalin,
        "umur_kehamilan": umurKehamilan,
        "penolongan_persalinan": penolonganPersalinan,
        "keadaan_ibu": keadaanIbu,
        "catatan_tambahan": catatanTambahan,
      };
}
