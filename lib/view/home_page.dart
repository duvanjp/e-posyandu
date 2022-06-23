import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/view/catatan_page.dart';
import 'package:e_posyandu/view/monitoring/monitoring_page.dart';
import 'package:e_posyandu/view/nfc_page.dart';
import 'package:e_posyandu/view/patient_page.dart';
import 'package:e_posyandu/view/profil_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          pageSnapping: false,
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            PatientPage(),
            CatatanPage(),
            MonitoringPage(),
            NFCPage(),
            ProfilPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        backgroundColor: Colors.white,
        elevation: 5,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.disableGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        iconSize: 26,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (key) {
          setState(() {
            pageIndex = key;
            _pageController.jumpToPage(key);
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: "Pasien",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: "Catatan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: "Monitoring",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_rounded),
            label: "NFC",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
