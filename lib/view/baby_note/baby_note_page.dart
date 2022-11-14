part of '../pages.dart';

class BabyNotePage extends StatelessWidget {
  final Patient patient;
  BabyNotePage({required this.patient});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Imunisasi"),
              Tab(text: "Masalah Perkembangan"),
            ],
          ),
          title: const Text('Catatan Anak'),
        ),
        body: TabBarView(
          children: [
            ImmunizationPage(patient: patient),
            BabyDevelopmentProblemPage(patient: patient),
          ],
        ),
      ),
    );
  }
}
