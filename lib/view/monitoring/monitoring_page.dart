part of '../pages.dart';

class MonitoringPage extends StatelessWidget {
  final Patient patient;
  MonitoringPage({required this.patient});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Kontrol Anak"),
              Tab(text: "Analisis Gizi Balita"),
            ],
          ),
          title: const Text('Monitoring Anak'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NutritionInfoPage()));
              },
              icon: Icon(Icons.info_outline_rounded),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            BabyContolPage(patient: patient),
            ToddlerNutritionAnalysisPage(patient: patient),
          ],
        ),
      ),
    );
  }
}
