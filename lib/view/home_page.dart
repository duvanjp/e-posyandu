part of 'pages.dart';

class HomePage extends StatefulWidget {
  final bool isAdmin;
  const HomePage({Key? key, this.isAdmin = true}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int pageIndex = 0;
  List<Widget> AdminRole = [
    PatientPage(),
    // CatatanPage(),
    // MonitoringPage(),
    NFCPage(),
    ProfilPage(),
  ];

  List<BottomNavigationBarItem> itemAdminRole = [
    BottomNavigationBarItem(
      icon: Icon(Icons.local_hospital),
      label: "Pasien",
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.receipt_long_rounded),
    //   label: "Catatan",
    // ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.library_books_rounded),
    //   label: "Monitoring",
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.verified_user_rounded),
      label: "NFC",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      label: "Profil",
    ),
  ];

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
          children: AdminRole,
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
        items: itemAdminRole,
      ),
    );
  }
}
