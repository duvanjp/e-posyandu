part of 'models.dart';

class User {
  String alamatPetugas,
      alamatPosyandu,
      email,
      fotoPetugas,
      namaPetugas,
      namaPosyandu,
      nomorPetugas,
      password;
  String? referenceId;

  User(
      {this.referenceId,
      required this.alamatPetugas,
      required this.alamatPosyandu,
      required this.email,
      required this.fotoPetugas,
      required this.namaPetugas,
      required this.namaPosyandu,
      required this.nomorPetugas,
      required this.password});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = User.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }
  // 6
  factory User.fromJson(Map<String, dynamic> json) => User(
        alamatPosyandu: json['alamat_posyandu'] as String,
        alamatPetugas: json['alamat_petugas'] as String,
        email: json['email'] as String,
        fotoPetugas: json['foto_petugas'] as String,
        nomorPetugas: json['nomor_petugas'] as String,
        namaPosyandu: json['nama_posyandu'] as String,
        namaPetugas: json['nama_petugas'] as String,
        password: json['password'] as String,
      );
  // 7
  Map<String, dynamic> toJson() => _patientToJson(this);

  Map<String, dynamic> _patientToJson(User instance) => <String, dynamic>{
        'alamat_posyandu': instance.alamatPosyandu,
        'alamat_petugas': instance.alamatPetugas,
        'email': instance.email,
        'foto_petugas': instance.fotoPetugas,
        'nomor_petugas': instance.nomorPetugas,
        'nama_posyandu': instance.namaPosyandu,
        'nama_petugas': instance.namaPetugas,
        'password': instance.password,
      };
}
