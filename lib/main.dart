import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/bloc/patient/patient_cubit.dart';
import 'package:e_posyandu/bloc/user/user_cubit.dart';
import 'package:e_posyandu/firebase_options.dart';
import 'package:e_posyandu/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late UserCubit userCubit;
  late PatientCubit patientCubit;

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    userCubit  = UserCubit();
    patientCubit  = PatientCubit();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColor.darkPrimary));

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => userCubit,),
        BlocProvider<PatientCubit>(create: (context) => patientCubit,),
      ],
      child: MaterialApp(
            title: "E-Posyandu",
            debugShowCheckedModeBanner: false,
            color: AppColor.primary,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme: ColorScheme.light(primary: AppColor.primary),
            ),
            home: LoginPage(),
          ),
    );
  }
}
