part of 'models.dart';

BabyControl babyControlFromJson(String str) =>
    BabyControl.fromJson(json.decode(str));

String babyControlToJson(BabyControl data) => json.encode(data.toJson());

class BabyControl {
  BabyControl({
    this.referenceId,
    required this.namaAnak,
    required this.umur,
    required this.beratBadan,
    required this.tinggiBadan,
    required this.keluhan,
    required this.frekNafas,
    required this.frekJantung,
    required this.diare,
    required this.ikterus,
    required this.statusImunisasi,
    required this.keluhanLain,
    required this.tindakanIbu,
    required this.namaPemeriksa,
    required this.tanggalKontrol,
  });

  String? referenceId;
  String namaAnak;
  double umur;
  double beratBadan;
  String tinggiBadan;
  String keluhan;
  String frekNafas;
  String frekJantung;
  String diare;
  String ikterus;
  String statusImunisasi;
  String keluhanLain;
  String tindakanIbu;
  String namaPemeriksa;
  String tanggalKontrol;

  factory BabyControl.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet =
        BabyControl.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory BabyControl.fromJson(Map<String, dynamic> json) => BabyControl(
        namaAnak: json["nama_anak"],
        umur: json["umur"],
        beratBadan: json["berat_badan"],
        tinggiBadan: json["tinggi_badan"],
        keluhan: json["keluhan"],
        frekNafas: json["frek_nafas"],
        frekJantung: json["frek_jantung"],
        diare: json["diare"],
        ikterus: json["ikterus"],
        statusImunisasi: json["status_imunisasi"],
        keluhanLain: json["keluhan_lain"],
        tindakanIbu: json["tindakan_ibu"],
        namaPemeriksa: json["nama_pemeriksa"],
        tanggalKontrol: json["tanggal_kontrol"],
      );

  Map<String, dynamic> toJson() => {
        "nama_anak": namaAnak,
        "umur": umur,
        "berat_badan": beratBadan,
        "tinggi_badan": tinggiBadan,
        "keluhan": keluhan,
        "frek_nafas": frekNafas,
        "frek_jantung": frekJantung,
        "diare": diare,
        "ikterus": ikterus,
        "status_imunisasi": statusImunisasi,
        "keluhan_lain": keluhanLain,
        "tindakan_ibu": tindakanIbu,
        "nama_pemeriksa": namaPemeriksa,
        "tanggal_kontrol": tanggalKontrol,
      };

  String get status {
    String value = "";
    final age = this.umur.floor();
    final choosed = normalWeight.where((element) => element.age == age).first;
    print("Normal: ${choosed.tostring}");
    _normalIndicator = choosed.tostring;
    if (beratBadan < choosed.lowWeight) {
      final choosed = lessWeight.where((element) => element.age == age).first;
      print("Kurang: ${choosed.toLessString}");
      _lessIndicator = choosed.toLessString;
      if (beratBadan < choosed.lowWeight) {
        value = "Kekurangan Gizi";
      } else {
        value = "Hati-Hati Kurang Gizi";
      }
    } else if (beratBadan > choosed.topWeight) {
      final choosed = lessWeight.where((element) => element.age == age).first;
      _lessIndicator = choosed.toLessString;
      value = "Kelebihan Gizi";
    } else {
      final choosed = lessWeight.where((element) => element.age == age).first;
      _lessIndicator = choosed.toLessString;
      value = "Normal";
    }
    return value;
  }

  String _normalIndicator = "";
  String get normalIndicator => _normalIndicator;

  String _lessIndicator = "";
  String get lesslIndicator => _lessIndicator;

  String get currentWeight => "Age: $umur ($beratBadan kg)";
}

class BabyNutrition {
  double age;
  double lowWeight;
  double topWeight;

  BabyNutrition({
    required this.age,
    required this.lowWeight,
    required this.topWeight,
  });

  String get tostring => "Age: $age - ${age + 1}\n($lowWeight - $topWeight kg)";
  String get toLessString => "Age: $age - ${age + 1}\n(< $lowWeight kg)";
}

List<TextItemWidget> listFieldNormalWeight() {
  List<TextItemWidget> list = [];
  // list.add(TextItemWidget(title: "Umur", text: "Berat Badan (Kg)"));
  for (var i = 0; i < normalWeight.length; i++) {
    list.add(TextItemWidget(
        title: "${normalWeight[i].age.floor()} bulan",
        text: "${normalWeight[i].lowWeight} - ${normalWeight[i].topWeight}"));
  }
  return list;
}

List<TextItemWidget> listFieldNotNormalWeight() {
  List<TextItemWidget> list = [];
  // list.add(TextItemWidget(title: "Umur", text: "Berat Badan (Kg)"));
  for (var i = 0; i < lessWeight.length; i++) {
    list.add(TextItemWidget(
        title: "${lessWeight[i].age.floor()} bulan",
        text: " < ${lessWeight[i].lowWeight}"));
  }
  return list;
}

List<BabyNutrition> normalWeight = [
  BabyNutrition(age: 0, lowWeight: 2.5, topWeight: 3.9),
  BabyNutrition(age: 1, lowWeight: 3.4, topWeight: 5.1),
  BabyNutrition(age: 2, lowWeight: 4.3, topWeight: 6.3),
  BabyNutrition(age: 3, lowWeight: 5.0, topWeight: 7.2),
  BabyNutrition(age: 4, lowWeight: 5.6, topWeight: 7.8),
  BabyNutrition(age: 5, lowWeight: 6.0, topWeight: 8.4),
  BabyNutrition(age: 6, lowWeight: 6.4, topWeight: 8.8),
  BabyNutrition(age: 7, lowWeight: 6.7, topWeight: 9.2),
  BabyNutrition(age: 8, lowWeight: 6.9, topWeight: 9.6),
  BabyNutrition(age: 9, lowWeight: 7.1, topWeight: 9.9),
  BabyNutrition(age: 10, lowWeight: 7.4, topWeight: 10.2),
  BabyNutrition(age: 11, lowWeight: 7.6, topWeight: 10.5),
  BabyNutrition(age: 12, lowWeight: 7.7, topWeight: 10.8),
  BabyNutrition(age: 13, lowWeight: 7.9, topWeight: 11.0),
  BabyNutrition(age: 14, lowWeight: 8.1, topWeight: 11.3),
  BabyNutrition(age: 15, lowWeight: 8.3, topWeight: 11.5),
  BabyNutrition(age: 16, lowWeight: 8.4, topWeight: 11.9),
  BabyNutrition(age: 17, lowWeight: 8.6, topWeight: 12.0),
  BabyNutrition(age: 18, lowWeight: 8.8, topWeight: 12.2),
  BabyNutrition(age: 19, lowWeight: 8.9, topWeight: 12.5),
  BabyNutrition(age: 20, lowWeight: 9.1, topWeight: 12.7),
  BabyNutrition(age: 21, lowWeight: 9.2, topWeight: 12.9),
  BabyNutrition(age: 22, lowWeight: 9.4, topWeight: 13.2),
  BabyNutrition(age: 23, lowWeight: 9.5, topWeight: 13.4),
  BabyNutrition(age: 24, lowWeight: 9.7, topWeight: 13.6),
];

List<BabyNutrition> lessWeight = [
  BabyNutrition(age: 0, lowWeight: 2.0, topWeight: 2.5),
  BabyNutrition(age: 1, lowWeight: 2.8, topWeight: 3.4),
  BabyNutrition(age: 2, lowWeight: 3.4, topWeight: 4.3),
  BabyNutrition(age: 3, lowWeight: 4.0, topWeight: 5.0),
  BabyNutrition(age: 4, lowWeight: 4.4, topWeight: 5.6),
  BabyNutrition(age: 5, lowWeight: 4.8, topWeight: 6.0),
  BabyNutrition(age: 6, lowWeight: 5.1, topWeight: 6.4),
  BabyNutrition(age: 7, lowWeight: 5.3, topWeight: 6.7),
  BabyNutrition(age: 8, lowWeight: 5.6, topWeight: 6.9),
  BabyNutrition(age: 9, lowWeight: 5.8, topWeight: 7.1),
  BabyNutrition(age: 10, lowWeight: 6.0, topWeight: 7.4),
  BabyNutrition(age: 11, lowWeight: 6.1, topWeight: 7.6),
  BabyNutrition(age: 12, lowWeight: 6.3, topWeight: 7.7),
  BabyNutrition(age: 13, lowWeight: 6.5, topWeight: 7.9),
  BabyNutrition(age: 14, lowWeight: 6.7, topWeight: 8.1),
  BabyNutrition(age: 15, lowWeight: 6.8, topWeight: 8.3),
  BabyNutrition(age: 16, lowWeight: 7.0, topWeight: 8.4),
  BabyNutrition(age: 17, lowWeight: 7.1, topWeight: 8.6),
  BabyNutrition(age: 18, lowWeight: 7.2, topWeight: 8.8),
  BabyNutrition(age: 19, lowWeight: 7.3, topWeight: 8.9),
  BabyNutrition(age: 20, lowWeight: 7.4, topWeight: 9.1),
  BabyNutrition(age: 21, lowWeight: 7.6, topWeight: 9.2),
  BabyNutrition(age: 22, lowWeight: 7.7, topWeight: 9.4),
  BabyNutrition(age: 23, lowWeight: 7.8, topWeight: 9.5),
  BabyNutrition(age: 24, lowWeight: 7.9, topWeight: 9.7),
];
