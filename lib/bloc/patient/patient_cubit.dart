import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_posyandu/firebase/patient_repository.dart';
import 'package:e_posyandu/helper/constant_helper.dart';
import 'package:e_posyandu/helper/preferences.dart';
import 'package:e_posyandu/model/models.dart';
import 'package:equatable/equatable.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(PatientInitial());

  PatientRepository _patientRepository = PatientRepository();

  List<Patient> listPatient = [];
  List<Baby> listBaby = [];
  List<Immunization> listImmunization = [];
  List<DevelopmentProblem> listDevProblem = [];
  List<BabyControl> listBabyControl = [];
  List<Maternity> listMaternity = [];
  List<Pregnant> listPregnant = [];
  List<Postpartum> listPostpartum = [];
  late Patient patient;

  // get list of data patient
  void load() async {
    emit(PatientLoadingLoadData());

    List<Patient> tempListPatient = [];

    QuerySnapshot querySnapshot = await _patientRepository.collection.get();
    for (int i = 0; i < querySnapshot.size; i++) {
      tempListPatient.add(Patient.fromSnapshot(querySnapshot.docs[i]));
    }

    listPatient = tempListPatient;

    emit(PatientLoaded());
  }

  // get baby data
  void loadBabyData(Patient patient) async {
    emit(BabyLoadLoading());

    List<Baby> tempListBaby = [];

    QuerySnapshot querySnapshot = await _patientRepository.getBabyData(patient);
    for (int i = 0; i < querySnapshot.size; i++) {
      tempListBaby.add(Baby.fromSnapshot(querySnapshot.docs[i]));
    }

    listBaby = tempListBaby;

    emit(BabyLoaded());
  }

  // save new baby data
  void saveBabyData(String? referenceId, Baby baby) async {
    emit(BabySavedLoading());

    try {
      await _patientRepository.saveBabyData(referenceId!, baby);
      emit(BabySavedSuccess());
    } catch (e) {
      print(e.toString());
    }
  }

  // get imunisasi data
  void getImmunizationData(String? referenceId) async {
    emit(ImmunizationLoading());
    try {
      List<Immunization> tempListImmunization = [];

      QuerySnapshot querySnapshot =
          await _patientRepository.getImmunizationData(referenceId);
      for (int i = 0; i < querySnapshot.size; i++) {
        tempListImmunization
            .add(Immunization.fromSnapshot(querySnapshot.docs[i]));
      }

      listImmunization = tempListImmunization;

      emit(ImmunizationLoaded());
    } catch (e) {
      print(e.toString());
    }
  }

  // save immunization data
  void saveImmunizationData(
      String? referenceId, Immunization immunization) async {
    emit(ImmunizationSaveLoading());
    try {
      await _patientRepository.saveImmunizationData(referenceId!, immunization);
      emit(ImmunizationSaveSuccess());
    } catch (e) {}
  }

  // get development problem data
  void getProblemDevData(String? referenceId) async {
    emit(DevelopmentProblemLoading());
    try {
      List<DevelopmentProblem> tempListDevProblem = [];

      QuerySnapshot querySnapshot =
          await _patientRepository.getDevProblemData(referenceId);
      for (int i = 0; i < querySnapshot.size; i++) {
        tempListDevProblem
            .add(DevelopmentProblem.fromSnapshot(querySnapshot.docs[i]));
      }

      listDevProblem = tempListDevProblem;

      emit(DevelopmentProblemLoaded());
    } catch (e) {
      print(e.toString());
    }
  }

  // save development problem data
  void saveDevProblemData(
      String? referenceId, DevelopmentProblem developmentProblem) async {
    emit(DevelopmentProblemSaveLoading());
    try {
      await _patientRepository.saveDevProblemData(
          referenceId!, developmentProblem);
      emit(DevelopmentProblemSaveSuccess());
    } catch (e) {}
  }

  // get baby control data
  void getBabyControlData(String? referenceId) async {
    emit(BabyControlLoading());
    try {
      List<BabyControl> tempListBabyControl = [];

      QuerySnapshot querySnapshot =
          await _patientRepository.getBabyControlData(referenceId);
      for (int i = 0; i < querySnapshot.size; i++) {
        tempListBabyControl
            .add(BabyControl.fromSnapshot(querySnapshot.docs[i]));
      }
      tempListBabyControl.sort((a, b) => a.umur.compareTo(b.umur));
      listBabyControl = tempListBabyControl;
      emit(BabyControlLoaded());
    } catch (e) {
      print(e.toString());
    }
  }

  // save baby control data
  void saveBabyControlData(String? referenceId, BabyControl babyControl) async {
    emit(BabyControlSaveLoading());
    try {
      await _patientRepository.saveBabyControlData(referenceId!, babyControl);
      emit(BabyControlSaveSuccess());
    } catch (e) {}
  }

  //get analysis data
  void getAnalysisBabyData(Patient patient) async {
    emit(BabyAnalysisLoading());
    try {
      List<Baby> tempListBaby = [];

      QuerySnapshot querySnapshot =
          await _patientRepository.getBabyData(patient);
      for (int i = 0; i < querySnapshot.size; i++) {
        tempListBaby.add(Baby.fromSnapshot(querySnapshot.docs[i]));
      }
      listBaby = tempListBaby;

      if (listBaby.length != 0) {
        List<BabyControl> querySnapshot2 = await _patientRepository
            .getSomeBabyControlData(patient.referenceId, listBaby[0]);

        querySnapshot2.sort((a, b) => a.umur.compareTo(b.umur));

        listBabyControl = querySnapshot2;
      }

      emit(BabyAnalysisLoaded());
    } catch (e) {
      print(e.toString());
    }
  }

  void getSomeAnalysisBabyData(Patient patient, Baby baby) async {
    emit(SomeAnalysisBabyLoading());
    try {
      List<BabyControl> querySnapshot2 = await _patientRepository
          .getSomeBabyControlData(patient.referenceId, baby);

      listBabyControl.clear();
      querySnapshot2.sort((a, b) => a.umur.compareTo(b.umur));
      listBabyControl.addAll(querySnapshot2);
      print("Jumlah: ${listBabyControl.length}");

      emit(SomeAnalysisBabyLoaded());
    } catch (e) {
      print(e.toString());
    }
  }

  // get catatan ibu bersalin
  void getMaternityNotesData(String? referenceId) async {
    emit(MaternityNotesLoading());
    try {
      List<Maternity> tempListMaternity = [];

      QuerySnapshot querySnapshot =
          await _patientRepository.getMaternityData(referenceId);
      for (int i = 0; i < querySnapshot.size; i++) {
        tempListMaternity.add(Maternity.fromSnapshot(querySnapshot.docs[i]));
      }

      listMaternity = tempListMaternity;

      emit(MaternityNotesLoaded());
    } catch (e) {
      print(e.toString());
    }
  }

  // save maternity data
  void saveMaternityData(String? referenceId, Maternity maternity) async {
    emit(MaternityNotesSaveLoading());

    try {
      await _patientRepository.saveMaternityData(referenceId!, maternity);
      emit(MaternityNotesSaveSuccess());
    } catch (e) {
      print(e.toString());
    }
  }

  // get pregnant data
  void getPregnantData(String? referenceId) async {
    emit(PregnantLoading());
    try {
      List<Pregnant> tempListPregnant = [];

      QuerySnapshot querySnapshot =
          await _patientRepository.getPregnantData(referenceId);
      for (int i = 0; i < querySnapshot.size; i++) {
        tempListPregnant.add(Pregnant.fromSnapshot(querySnapshot.docs[i]));
      }

      listPregnant = tempListPregnant;

      emit(PregnantLoaded());
    } catch (e) {
      print(e.toString());
    }
  }

  // save pregnant data
  void savePregnantData(String? referenceId, Pregnant pregnant) async {
    emit(PregnantSaveLoading());

    try {
      await _patientRepository.savePregnantData(referenceId!, pregnant);
      emit(PregnantSaveSuccess());
    } catch (e) {
      print(e.toString());
    }
  }

  // get nifas data
  void getPostpartumData(String? referenceId) async {
    emit(PostpartumLoading());
    try {
      List<Postpartum> tempListPostpartum = [];

      QuerySnapshot querySnapshot =
          await _patientRepository.getPostpartumData(referenceId);
      for (int i = 0; i < querySnapshot.size; i++) {
        tempListPostpartum.add(Postpartum.fromSnapshot(querySnapshot.docs[i]));
      }

      listPostpartum = tempListPostpartum;

      emit(PostpartumLoaded());
    } catch (e) {
      print(e.toString());
    }
  }

  // save nifas data
  void savePostpartumData(String? referenceId, Postpartum postpartum) async {
    emit(PostpartumSaveLoading());

    try {
      await _patientRepository.savePostpartumData(referenceId!, postpartum);
      emit(PostpartumSaveSuccess());
    } catch (e) {
      print(e.toString());
    }
  }

  // regis new patient
  void register(Patient patient) async {
    emit(PatientLoading());

    //checking data first
    QuerySnapshot querySnapshot = await _patientRepository.collection
        .where("username", isEqualTo: patient.username)
        .get();

    if (querySnapshot.size == 0) {
      DocumentReference<Object?> result =
          await _patientRepository.addPatient(patient);
      print(result);
      emit(PatientRegisSuccess(patient: patient));
    } else {
      emit(PatientExist());
    }
  }

  // edit patient
  void editDataPatient(Patient patient) async {
    emit(EditPatientLoading());
    try {
      await _patientRepository.updatePatient(patient);

      QuerySnapshot querySnapshot = await _patientRepository.collection
          .where("username", isEqualTo: patient.username)
          .get();
      Patient patientUpadated = Patient.fromSnapshot(querySnapshot.docs.first);

      emit(EditPatientRegisSuccess(patient: patientUpadated));
    } catch (e) {
      emit(EditPatientRegisFailed(error: e.toString()));
    }
  }

  // login
  void login(String username, String password) async {
    emit(PatientLoading());

    QuerySnapshot querySnapshot = await _patientRepository.collection
        .where("username", isEqualTo: username)
        .where("password", isEqualTo: password)
        .get();

    if (querySnapshot.size == 0) {
      print(querySnapshot.docs);
      emit(PatientExist(error: querySnapshot.docs));
    } else {
      patient = Patient.fromSnapshot(querySnapshot.docs.first);

      Prefs.setLoggedIn(true);
      Prefs.setUsername(patient.username);
      Prefs.setUserId(patient.referenceId ?? "");
      Prefs.setName(patient.namaIbu);
      Prefs.setRole(ConstantHelper.PASIEN);

      // SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      // sharedPreferences.setBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN, true);
      // sharedPreferences.setString(
      //     ConstantHelper.PREFS_USER_USERNAME, patient.username);
      // sharedPreferences.setString(
      //     ConstantHelper.PREFS_USER_ID, patient.referenceId!);
      // sharedPreferences.setString(
      //     ConstantHelper.PREFS_USER_NAME, patient.namaIbu);
      // sharedPreferences.setString(ConstantHelper.PREFS_USER_ROLE, "pasien");

      emit(PatientLoginSuccess(patient: patient));
    }
  }

  // log out
  void logOut() async {
    emit(PatientLoading());
    await Future.delayed(Duration(milliseconds: 500));
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    PreferencesHelper().clearPreference();
    emit(PatientLoggedOut());
  }

  // check the user
  void checkUserLogged(String username) async {
    QuerySnapshot querySnapshot = await _patientRepository.collection
        .where("username", isEqualTo: username)
        .get();

    if (querySnapshot.size == 0) {
      emit(PatientExist(error: ""));
    } else {
      print("masuk login sukses non petugas");
      patient = Patient.fromSnapshot(querySnapshot.docs.first);
      emit(PatientLoginSuccess(patient: patient));
    }
  }

  // read data
  void readData(String username, String password) async {
    emit(ReadDataLoading());

    QuerySnapshot querySnapshot = await _patientRepository.collection
        .where("username", isEqualTo: username)
        .where("password", isEqualTo: password)
        .get();

    if (querySnapshot.size == 0) {
      print(querySnapshot.docs);
      emit(ReadDataFailed());
    } else {
      patient = Patient.fromSnapshot(querySnapshot.docs.first);

      emit(ReadDataSuccess(patient: patient));
    }
  }
}
