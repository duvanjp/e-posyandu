part of 'models.dart';

DevelopmentProblem DevelopmentProblemFromJson(String str) =>
    DevelopmentProblem.fromJson(json.decode(str));

String DevelopmentProblemToJson(DevelopmentProblem data) =>
    json.encode(data.toJson());

class DevelopmentProblem {
  DevelopmentProblem({
    required this.namaAnak,
    required this.catatan,
    required this.namaPemeriksa,
    required this.permasalahan,
    required this.tanggalPemeriksaan,
    required this.tindakan,
    this.referenceId,
  });

  String? referenceId;
  String namaAnak;
  String catatan;
  String namaPemeriksa;
  String permasalahan;
  String tanggalPemeriksaan;
  String tindakan;

  factory DevelopmentProblem.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet =
        DevelopmentProblem.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory DevelopmentProblem.fromJson(Map<String, dynamic> json) =>
      DevelopmentProblem(
        namaAnak: json["nama_anak"],
        catatan: json["catatan"],
        namaPemeriksa: json["nama_pemeriksa"],
        permasalahan: json["permasalahan"],
        tanggalPemeriksaan: json["tanggal_pemeriksaan"],
        tindakan: json["tindakan"],
      );

  Map<String, dynamic> toJson() => {
        "nama_anak": namaAnak,
        "catatan": catatan,
        "nama_pemeriksa": namaPemeriksa,
        "permasalahan": permasalahan,
        "tanggal_pemeriksaan": tanggalPemeriksaan,
        "tindakan": tindakan,
      };
}
