part of 'models.dart';

Immunization ImmunizationFromJson(String str) =>
    Immunization.fromJson(json.decode(str));

String ImmunizationToJson(Immunization data) => json.encode(data.toJson());

class Immunization {
  Immunization({
    required this.namaAnak,
    required this.catatan,
    required this.jenisImmunization,
    required this.tglImmunization,
    required this.namaPetugas,
    this.referenceId,
  });

  String? referenceId;
  String namaAnak;
  String catatan;
  String jenisImmunization;
  String tglImmunization;
  String namaPetugas;

  factory Immunization.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet =
        Immunization.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory Immunization.fromJson(Map<String, dynamic> json) => Immunization(
        namaAnak: json["nama_anak"],
        catatan: json["catatan"],
        jenisImmunization: json["jenis_immunization"],
        tglImmunization: json["tgl_immunization"],
        namaPetugas: json["nama_petugas"],
      );

  Map<String, dynamic> toJson() => {
        "nama_anak": namaAnak,
        "catatan": catatan,
        "jenis_immunization": jenisImmunization,
        "tgl_immunization": tglImmunization,
        "nama_petugas": namaPetugas,
      };
}
