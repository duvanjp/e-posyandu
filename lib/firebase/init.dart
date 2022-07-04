import 'package:e_posyandu/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class InitFirebase {
  void init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}