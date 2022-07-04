import 'package:e_posyandu/view/monitoring/bb_page.dart';
import 'package:flutter/material.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Kontrol Anak"),
              Tab(text: "Analisis Gizi Balita"),
            ],
          ),
          title: const Text('Monitoring Anak'),
        ),
        body: TabBarView(
          children: [
            BBPage(),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
