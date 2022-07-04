import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  String agamaIbu, agamaSuami, alamatRumah, goldarahIbu, namaIbu, namaSuami, noTelp, pekerjaanSuami, pekerjaanIbu, pendidikanSuami, pendidikanIbu, ttlIbu, ttlSuami;
  String? referenceId;
  // 4
  Patient({required this.agamaIbu, this.referenceId, required this.agamaSuami, required this.alamatRumah, required this.goldarahIbu, required this.namaIbu, required this.namaSuami, required this.noTelp, required this.pekerjaanIbu, required this.pekerjaanSuami, required this.pendidikanIbu, required this.pendidikanSuami, required this.ttlIbu, required this.ttlSuami});
  // 5
  factory Patient.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Patient.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }
  // 6
  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
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