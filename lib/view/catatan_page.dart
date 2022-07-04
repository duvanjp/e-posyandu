import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/view/catatan/bayilahir_page.dart';
import 'package:e_posyandu/view/catatan/ibubersalin_page.dart';
import 'package:e_posyandu/view/catatan/ibuhamil_page.dart';
import 'package:e_posyandu/view/catatan/ibunifas_page.dart';
import 'package:e_posyandu/view/catatan/list_bayilahir_page.dart';
import 'package:e_posyandu/view/catatan/list_ibubersalin_page.dart';
import 'package:e_posyandu/view/catatan/list_ibuhamil_page.dart';
import 'package:e_posyandu/view/catatan/list_ibunifas_page.dart';
import 'package:e_posyandu/view/catatan_anak/anak_page.dart';
import 'package:e_posyandu/widget/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CatatanPage extends StatelessWidget {
  const CatatanPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Catatan Kesehatan",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: AppColor.primary,
          elevation: 1,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text("Ibu 1"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("Ibu 2"),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text("Ibu 3"),
                          ),
                        ], 
                        isExpanded: true,
                        value: 1,
                        onChanged: (value) {},
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 0,
                                color: AppColor.boxGrey,
                                offset: Offset(0, 0),
                              ),
                            ]),
                        child: Column(
                          children: [
                            Menu(
                              name: "Catatan Ibu Hamil",
                              icon: Icons.pregnant_woman_outlined,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListIbuhamilPage()));
                              },
                            ),
                            Menu(
                              name: "Catatan Ibu Bersalin",
                              icon: Icons.local_hospital_outlined,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListIbubersalinPage()));
                              },
                            ),
                            Menu(
                              name: "Catatan Bayi Baru Lahir",
                              icon: Icons.child_friendly_outlined,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListBayilahirPage()));
                              },
                            ),
                            Menu(
                              name: "Catatan Ibu Nifas",
                              icon: Icons.list,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListIbunifasPage()));
                              },
                            ),
                            Menu(
                              name: "Catatan Anak",
                              icon: Icons.child_care,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnakPage()));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
