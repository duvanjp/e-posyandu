import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/model/models.dart';

class PatientRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('peserta');

  Future<QuerySnapshot> getBabyData(Patient patient) {
    return FirebaseFirestore.instance
        .collection(
            GlobalHelper().getCollectionPath(patient.referenceId, "anak"))
        .get();
  }

  Future<DocumentReference> saveBabyData(String referenceId, Baby baby) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper().getCollectionPath(referenceId, "anak"))
        .add(baby.toJson());
  }

  Future<QuerySnapshot> getImmunizationData(String? referenceId) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper().getCollectionPath(referenceId, "imunisasi"))
        .get();
  }

  Future<DocumentReference> saveImmunizationData(
      String referenceId, Immunization immunization) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper().getCollectionPath(referenceId, "imunisasi"))
        .add(immunization.toJson());
  }

  Future<QuerySnapshot> getDevProblemData(String? referenceId) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper()
            .getCollectionPath(referenceId, "masalah_perkembangan"))
        .get();
  }

  Future<DocumentReference> saveDevProblemData(
      String referenceId, DevelopmentProblem developmentProblem) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper()
            .getCollectionPath(referenceId, "masalah_perkembangan"))
        .add(developmentProblem.toJson());
  }

  Future<QuerySnapshot> getBabyControlData(String? referenceId) {
    return FirebaseFirestore.instance
        .collection(
            GlobalHelper().getCollectionPath(referenceId, "kontrol_anak"))
        .get();
  }

  Future<DocumentReference> saveBabyControlData(
      String referenceId, BabyControl babyControl) {
    return FirebaseFirestore.instance
        .collection(
            GlobalHelper().getCollectionPath(referenceId, "kontrol_anak"))
        .add(babyControl.toJson());
  }

  Future<List<BabyControl>> getSomeBabyControlData(
      String? referenceId, Baby baby) async {
    List<BabyControl> babyListControl = [];
    await FirebaseFirestore.instance
        .collection(
            GlobalHelper().getCollectionPath(referenceId, "kontrol_anak"))
        .get()
        .then((value) {
      for (int i = 0; i < value.size; i++) {
        final babyControl = BabyControl.fromSnapshot(value.docs[i]);
        print("Nama bayi yg didapat: ${babyControl.namaAnak}");
        print("Nama bayi pilihan: ${baby.namaAnak}");
        if (babyControl.namaAnak == baby.namaAnak) {
          print(babyControl.toJson());
          babyListControl.add(babyControl);
        }
      }
    });
    return babyListControl;
  }

  Future<QuerySnapshot> getMaternityData(String? referenceId) {
    return FirebaseFirestore.instance
        .collection(
            GlobalHelper().getCollectionPath(referenceId, "ibu_bersalin"))
        .get();
  }

  Future<DocumentReference> saveMaternityData(
      String referenceId, Maternity maternity) {
    return FirebaseFirestore.instance
        .collection(
            GlobalHelper().getCollectionPath(referenceId, "ibu_bersalin"))
        .add(maternity.toJson());
  }

  Future<QuerySnapshot> getPregnantData(String? referenceId) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper().getCollectionPath(referenceId, "ibu_hamil"))
        .get();
  }

  Future<DocumentReference> savePregnantData(
      String referenceId, Pregnant pregnant) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper().getCollectionPath(referenceId, "ibu_hamil"))
        .add(pregnant.toJson());
  }

  Future<QuerySnapshot> getPostpartumData(String? referenceId) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper().getCollectionPath(referenceId, "nifas"))
        .get();
  }

  Future<DocumentReference> savePostpartumData(
      String referenceId, Postpartum postpartum) {
    return FirebaseFirestore.instance
        .collection(GlobalHelper().getCollectionPath(referenceId, "nifas"))
        .add(postpartum.toJson());
  }

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPatient(Patient patient) {
    return collection.add(patient.toJson());
  }

  Future<void> updatePatient(Patient patient) async {
    print("patient id: ${patient.referenceId}");
    await collection.doc(patient.referenceId).update(patient.toJson());
  }

  void deletePatient(Patient patient) async {
    await collection.doc(patient.referenceId).delete();
  }
}
