import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/view/catatan/ibubersalin_page.dart';
import 'package:e_posyandu/view/catatan/ibuhamil_page.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';


class ListIbubersalinPage extends StatefulWidget {
  ListIbubersalinPage({Key? key}) : super(key: key);

  @override
  _ListIbubersalinPageState createState() => _ListIbubersalinPageState();
}

class _ListIbubersalinPageState extends State<ListIbubersalinPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Daftar Catatan Ibu Bersalin",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
            ),
          ),
          Expanded(
            child: Container(
              color: AppColor.grey,
              child: ListView.builder(
                itemCount: 5,
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.boxGrey,
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: const Offset(0, 0))
                          ]),
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      margin: EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          " ${index + 20} Juni 2022 06:15",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: BaseButton(
              onPressed: () {
                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IbusalinPage()));
              },
              text: "Tambah Catatan Ibu Bersalin",
              radius: 8,
              padding: 16,
            ),
          )
        ],
      ),
    );
  }
}