import 'package:e_posyandu/app_color.dart';
import 'package:flutter/material.dart';

class NFCPage extends StatefulWidget {
  NFCPage({Key? key}) : super(key: key);

  @override
  State<NFCPage> createState() => _NFCPageState();
}

class _NFCPageState extends State<NFCPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Sinkroninasi Data Pasien",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Container(
          alignment: Alignment.center,
          child: MaterialButton(
            color: Colors.blue,
            shape: const CircleBorder(),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(100),
              child: Text(
                'Update Kartu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          )),
    );
  }
}
