import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_posyandu/firebase/patient_repository.dart';
import 'package:e_posyandu/model/patient.dart';
import 'package:equatable/equatable.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(PatientInitial());

  PatientRepository _patientRepository = PatientRepository();

  List<Patient> listPatient = [];

  void load() async {
    emit(PatientInitial());

    List<Patient> tempListPatient = [];

    QuerySnapshot querySnapshot = await _patientRepository.collection.get();
    for (int i = 0; i < querySnapshot.size; i++) {
      tempListPatient.add(Patient.fromSnapshot(querySnapshot.docs[i]));
    }

    listPatient = tempListPatient;

    emit(PatientLoaded());
  }
}
