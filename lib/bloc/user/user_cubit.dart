import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_posyandu/firebase/user_repository.dart';
import 'package:e_posyandu/helper/constant_helper.dart';
import 'package:e_posyandu/helper/preferences.dart';
import 'package:e_posyandu/model/models.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  User? user;
  UserRepository _userRepository = UserRepository();

  void login(String phone, String password) async {
    emit(UserLoading());

    QuerySnapshot querySnapshot = await _userRepository.collection
        .where("nama_petugas", isEqualTo: phone)
        .where("password", isEqualTo: password)
        .get();

    if (querySnapshot.size == 0) {
      print(querySnapshot.docs);
      emit(UserFailedLogin(error: querySnapshot.docs));
    } else {
      user = User.fromSnapshot(querySnapshot.docs.first);

      // new way
      Prefs.setLoggedIn(true);
      Prefs.setEmail(user!.email);
      Prefs.setUserId(user!.referenceId ?? "");
      Prefs.setName(user!.namaPetugas);
      Prefs.setRole(ConstantHelper.PETUGAS);

      // old way
      // SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      // sharedPreferences.setBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN, true);
      // sharedPreferences.setString(ConstantHelper.PREFS_USER_EMAIL, user!.email);
      // sharedPreferences.setString(
      //     ConstantHelper.PREFS_USER_ID, user!.referenceId!);
      // sharedPreferences.setString(
      //     ConstantHelper.PREFS_USER_NAME, user!.namaPetugas);
      // sharedPreferences.setString(ConstantHelper.PREFS_USER_ROLE, "petugas");

      emit(UserLoggedIn());
    }
  }

  void checkUserLogged(String email) async {
    QuerySnapshot querySnapshot =
        await _userRepository.collection.where("email", isEqualTo: email).get();

    if (querySnapshot.size == 0) {
      emit(UserNotLoggedIn());
    } else {
      user = User.fromSnapshot(querySnapshot.docs.first);
      emit(UserLoggedIn());
    }
  }

  void logOut() async {
    emit(UserLoading());
    await Future.delayed(Duration(milliseconds: 500));
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    PreferencesHelper().clearPreference();
    emit(UserNotLoggedIn());
  }
}
