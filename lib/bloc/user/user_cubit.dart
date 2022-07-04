import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_posyandu/firebase/user_repository.dart';
import 'package:e_posyandu/helper/constant_helper.dart';
import 'package:e_posyandu/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  User? user;
  UserRepository _userRepository = UserRepository();

  void login(String phone, String password) async {
    emit(UserInitial());

    QuerySnapshot querySnapshot = await _userRepository.collection
        .where("nomor_petugas", isEqualTo: phone)
        .where("password", isEqualTo: password)
        .get();

    if (querySnapshot.size == 0) {
      emit(UserFailedLogin());
    } else {
      user = User.fromSnapshot(querySnapshot.docs.first);

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN, true);
      sharedPreferences.setString(ConstantHelper.PREFS_USER_EMAIL, user!.email);
      sharedPreferences.setString(ConstantHelper.PREFS_USER_ID, user!.referenceId!);
      sharedPreferences.setString(ConstantHelper.PREFS_USER_NAME, user!.namaPetugas);
      sharedPreferences.setString(ConstantHelper.PREFS_USER_ROLE, "petugas");

      emit(UserLoggedIn());
    }
  }
}
