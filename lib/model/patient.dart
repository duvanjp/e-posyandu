part of 'models.dart';

class Patient {
  String username;
  String password;
  String agamaIbu;
  String agamaSuami;
  String alamatRumah;
  String goldarahIbu;
  String namaIbu;
  String namaSuami;
  String noTelp;
  String pekerjaanSuami;
  String pekerjaanIbu;
  String pendidikanSuami;
  String pendidikanIbu;
  String ttlIbu;
  String ttlSuami;
  String? referenceId;
  // 4
  Patient({
    required this.username,
    required this.password,
    required this.agamaIbu,
    required this.agamaSuami,
    required this.alamatRumah,
    required this.goldarahIbu,
    required this.namaIbu,
    required this.namaSuami,
    required this.noTelp,
    required this.pekerjaanIbu,
    required this.pekerjaanSuami,
    required this.pendidikanIbu,
    required this.pendidikanSuami,
    required this.ttlIbu,
    required this.ttlSuami,
    this.referenceId,
  });
  // 5
  factory Patient.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Patient.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }
  // 6
  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        username: json['username'] == null ? "" : json['username'] as String,
        password: json['password'] == null ? "" : json['password'] as String,
        alamatRumah: json['alamat_rumah'] as String,
        agamaSuami: json['agama_suami'] as String,
        agamaIbu: json['agama_ibu'] as String,
        goldarahIbu: json['goldarah_ibu'] as String,
        namaIbu: json['nama_ibu'] as String,
        namaSuami: json['nama_suami'] as String,
        noTelp: json['notelp'] as String,
        pekerjaanIbu: json['pekerjaan_ibu'] as String,
        pekerjaanSuami: json['pekerjaan_suami'] as String,
        pendidikanIbu: json['pendidikan_ibu'] as String,
        pendidikanSuami: json['pendidikan_suami'] as String,
        ttlIbu: json['ttl_ibu'] as String,
        ttlSuami: json['ttl_suami'] as String,
      );
  // 7
  Map<String, dynamic> toJson() => _patientToJson(this);

  Map<String, dynamic> _patientToJson(Patient instance) => <String, dynamic>{
        'username': instance.username,
        'password': instance.password,
        'alamat_rumah': instance.alamatRumah,
        'agama_suami': instance.agamaSuami,
        'agama_ibu': instance.agamaIbu,
        'goldarah_ibu': instance.goldarahIbu,
        'nama_ibu': instance.namaIbu,
        'nama_suami': instance.namaSuami,
        'notelp': instance.noTelp,
        'pekerjaan_ibu': instance.pekerjaanIbu,
        'pekerjaan_suami': instance.pekerjaanSuami,
        'pendidikan_ibu': instance.pendidikanIbu,
        'pendidikan_suami': instance.pendidikanSuami,
        'ttl_ibu': instance.ttlIbu,
        'ttl_suami': instance.ttlSuami,
      };
}
