part of '../pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/logo.png'),
      nextScreen: const OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late UserCubit userCubit;
  late PatientCubit patientCubit;
  @override
  void initState() {
    checkRole();
    super.initState();
  }

  checkRole() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = await Prefs.getLoggedIn;
    // sharedPreferences.getBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN) ??
    //     false;
    if (isLoggedIn) {
      final role = await Prefs.getRole;
      // sharedPreferences.getString(ConstantHelper.PREFS_USER_ROLE);

      if (role == "petugas") {
        final email = await Prefs.getEmail;
        // sharedPreferences.getString(ConstantHelper.PREFS_USER_EMAIL);
        userCubit = BlocProvider.of<UserCubit>(context);
        userCubit.checkUserLogged(email);
      } else {
        print("masuk non petugas");
        final username = await Prefs.getUsername;
        // sharedPreferences.getString(ConstantHelper.PREFS_USER_USERNAME);
        patientCubit = BlocProvider.of<PatientCubit>(context);
        patientCubit.checkUserLogged(username);
      }
    } else {
      GlobalHelper().toWelcomePage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoggedIn) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()),
                  (Route<dynamic> route) => false);
            } else if (state is UserNotLoggedIn) {
              GlobalHelper().toWelcomePage(context);
            }
          },
        ),
        BlocListener<PatientCubit, PatientState>(
          listener: (context, state) {
            if (state is PatientLoginSuccess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CatatanPage(patient: state.patient, isAdmin: false)),
                  (Route<dynamic> route) => false);
            } else if (state is PatientExist) {
              GlobalHelper().toWelcomePage(context);
            }
          },
        ),
      ],
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Center(
              child: Image.asset("assets/logo.png"),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.5),
              child:
                  Center(child: CircularProgressIndicator(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
