import 'package:e_posyandu/view/catatan_anak/imunisasi_page.dart';
import 'package:e_posyandu/view/catatan_anak/perkembangan_page.dart';
import 'package:e_posyandu/view/monitoring/bb_page.dart';
import 'package:flutter/material.dart';

class AnakPage extends StatelessWidget {
  const AnakPage({super.key});

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
            ImunisasiPage(),
            PerkembanganPage(),
          ],
        ),
      ),
    );
  }
}
