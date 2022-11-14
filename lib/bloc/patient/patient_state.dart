part of 'patient_cubit.dart';

abstract class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object> get props => [];
}

class PatientInitial extends PatientState {}

class PatientLoadingLoadData extends PatientState {}

class PatientLoaded extends PatientState {}

class PatientLoading extends PatientState {}

class PatientRegisSuccess extends PatientState {
  final Patient patient;
  PatientRegisSuccess({required this.patient});
}

class EditPatientLoading extends PatientState {}

class EditPatientRegisSuccess extends PatientState {
  final Patient patient;
  EditPatientRegisSuccess({required this.patient});
}

class EditPatientRegisFailed extends PatientState {
  final String error;
  EditPatientRegisFailed({required this.error});
}

class PatientExist extends PatientState {
  final error;
  PatientExist({this.error});
}

class PatientLoginSuccess extends PatientState {
  final Patient patient;
  PatientLoginSuccess({required this.patient});
}

class PatientLoggedOut extends PatientState {}

class BabyLoadLoading extends PatientState {}

class BabyLoaded extends PatientState {}

class BabySavedLoading extends PatientState {}

class BabySavedSuccess extends PatientState {}

class ImmunizationLoading extends PatientState {}

class ImmunizationLoaded extends PatientState {}

class ImmunizationSaveLoading extends PatientState {}

class ImmunizationSaveSuccess extends PatientState {}

class DevelopmentProblemLoading extends PatientState {}

class DevelopmentProblemLoaded extends PatientState {}

class DevelopmentProblemSaveLoading extends PatientState {}

class DevelopmentProblemSaveSuccess extends PatientState {}

class BabyControlLoading extends PatientState {}

class BabyControlLoaded extends PatientState {}

class BabyControlSaveLoading extends PatientState {}

class BabyControlSaveSuccess extends PatientState {}

class BabyAnalysisLoading extends PatientState {}

class BabyAnalysisLoaded extends PatientState {}

class SomeAnalysisBabyLoading extends PatientState {}

class SomeAnalysisBabyLoaded extends PatientState {}

class MaternityNotesLoading extends PatientState {}

class MaternityNotesLoaded extends PatientState {}

class MaternityNotesSaveLoading extends PatientState {}

class MaternityNotesSaveSuccess extends PatientState {}

class PregnantLoading extends PatientState {}

class PregnantLoaded extends PatientState {}

class PregnantSaveLoading extends PatientState {}

class PregnantSaveSuccess extends PatientState {}

class PostpartumLoading extends PatientState {}

class PostpartumLoaded extends PatientState {}

class PostpartumSaveLoading extends PatientState {}

class PostpartumSaveSuccess extends PatientState {}

class ReadDataLoading extends PatientState {}

class ReadDataSuccess extends PatientState {
  final Patient patient;
  ReadDataSuccess({required this.patient});
}

class ReadDataFailed extends PatientState {}
