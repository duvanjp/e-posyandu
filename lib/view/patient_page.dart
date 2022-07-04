import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/bloc/patient/patient_cubit.dart';
import 'package:e_posyandu/helper/global_helper.dart';
import 'package:e_posyandu/view/form_patient_page.dart';
import 'package:e_posyandu/widget/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PatientPage extends StatefulWidget {
  PatientPage({Key? key}) : super(key: key);

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  late PatientCubit patientCubit;

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    patientCubit.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: patientCubit,
      listener: (context, state) {

      },
      child: BlocBuilder(
        bloc: patientCubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              title: const Text(
                "Daftar Pasien",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              automaticallyImplyLeading: false,
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
                      itemCount: patientCubit.listPatient.length,
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
                                vertical: 10, horizontal: 10),
                            margin: EdgeInsets.only(bottom: 5),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.grey, width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.darkGrey,
                                      ),
                                      child: Text(
                                        GlobalHelper.getInitials(patientCubit.listPatient[index].namaIbu),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
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
                                                patientCubit.listPatient[index].namaIbu,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text(
                                                patientCubit.listPatient[index].noTelp,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: AppColor.darkGrey,
                                                  fontSize: 12,
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
                              builder: (context) => FormPatientPage()));
                    },
                    text: "Tambah Pasien",
                    radius: 8,
                    padding: 16,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}