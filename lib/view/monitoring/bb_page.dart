import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/view/monitoring/form_bb_page.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';

class BBPage extends StatefulWidget {
  BBPage({Key? key}) : super(key: key);

  @override
  _BBPageState createState() => _BBPageState();
}

class _BBPageState extends State<BBPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: AppColor.grey,
                child: ListView.builder(
                  itemCount: 4,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.boxGrey,
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: Offset(0, 0))
                          ]),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Kontrol Anak ke $index",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Sehat Dengan Catatan",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: BaseButton(
                onPressed: () {
                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormBBPage()));
                },
                text: "Tambah Catatan",
                radius: 8,
                padding: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
