import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_posyandu/model/patient.dart';

class PatientRepository {
  // 1
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('peserta');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addPatient(Patient patient) {
    return collection.add(patient.toJson());
  }
  // 4
  void updatePatient(Patient patient) async {
    await collection.doc(patient.referenceId).update(patient.toJson());
  }
  // 5
  void deletePatient(Patient patient) async {
    await collection.doc(patient.referenceId).delete();
  }
}