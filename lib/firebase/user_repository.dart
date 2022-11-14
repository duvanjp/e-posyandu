import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_posyandu/model/models.dart';

class UserRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('user');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // 3
  Future<DocumentReference> addPatient(User user) {
    return collection.add(user.toJson());
  }

  // 4
  void updatePatient(User user) async {
    await collection.doc(user.referenceId).update(user.toJson());
  }

  // 5
  void deletePatient(User user) async {
    await collection.doc(user.referenceId).delete();
  }
}
