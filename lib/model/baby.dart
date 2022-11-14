part of 'models.dart';

Baby babyFromJson(String str) => Baby.fromJson(json.decode(str));

String babyToJson(Baby data) => json.encode(data.toJson());

class Baby {
  Baby({
    this.referenceId,
    required this.namaAnak,
    required this.catatanAnak,
    required this.lingkarkepalaAnak,
    required this.kelaminAnak,
    required this.panjangAnak,
    required this.statusAnak,
    required this.tgllhrAnak,
    required this.beratAnak,
  });

  String? referenceId;
  String namaAnak;
  String catatanAnak;
  String lingkarkepalaAnak;
  String kelaminAnak;
  String panjangAnak;
  String statusAnak;
  String tgllhrAnak;
  String beratAnak;

  factory Baby.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Baby.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory Baby.fromJson(Map<String, dynamic> json) => Baby(
        namaAnak: json["nama_anak"],
        catatanAnak: json["catatan_anak"],
        lingkarkepalaAnak: json["lingkarkepala_anak"],
        kelaminAnak: json["kelamin_anak"],
        panjangAnak: json["panjang_anak"],
        statusAnak: json["status_anak"],
        tgllhrAnak: json["tgllhr_anak"],
        beratAnak: json["berat_anak"],
      );

  Map<String, dynamic> toJson() => {
        "nama_anak": namaAnak,
        "catatan_anak": catatanAnak,
        "lingkarkepala_anak": lingkarkepalaAnak,
        "kelamin_anak": kelaminAnak,
        "panjang_anak": panjangAnak,
        "status_anak": statusAnak,
        "tgllhr_anak": tgllhrAnak,
        "berat_anak": beratAnak,
      };
}
