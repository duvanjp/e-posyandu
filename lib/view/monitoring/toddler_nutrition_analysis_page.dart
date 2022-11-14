part of '../pages.dart';

class ToddlerNutritionAnalysisPage extends StatefulWidget {
  final Patient patient;
  const ToddlerNutritionAnalysisPage({Key? key, required this.patient})
      : super(key: key);

  @override
  State<ToddlerNutritionAnalysisPage> createState() =>
      _ToddlerNutritionAnalysisPageState();
}

class _ToddlerNutritionAnalysisPageState
    extends State<ToddlerNutritionAnalysisPage> {
  late PatientCubit patientCubit;
  bool isLoading = true;
  List<DropdownMenuItem<Baby>> listBabyMenu = [];
  late Baby selectedBaby;
  final List<ChartData> chartData = [
    ChartData(0, 0),
  ];
  late TooltipBehavior _tooltipBehavior;
  String statusNutrition = "";
  String normalNutrition = "";
  String lessNutrition = "";
  String currentWeight = "";

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    patientCubit.getAnalysisBabyData(widget.patient);
    _tooltipBehavior = TooltipBehavior(enable: true, header: "Umur : Berat");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is BabyAnalysisLoaded) {
          setState(() {
            if (patientCubit.listBaby.length != 0) {
              for (var i = 0; i < patientCubit.listBaby.length; i++) {
                final baby = patientCubit.listBaby[i];
                listBabyMenu.add(DropdownMenuItem(
                  value: baby,
                  child: Text(baby.namaAnak),
                ));
              }
              selectedBaby = patientCubit.listBaby[0];
              String value =
                  selectedBaby.beratAnak.replaceAll(RegExp(r'[A-Za-z]'), "");

              chartData.add(ChartData(0, double.parse(value)));
              for (var i = 0; i < patientCubit.listBabyControl.length; i++) {
                final babyControl = patientCubit.listBabyControl[i];
                chartData
                    .add(ChartData(babyControl.umur, babyControl.beratBadan));
              }
              chartData.sort((a, b) => a.x.compareTo(b.x));
            }
            isLoading = false;
          });
          if (patientCubit.listBabyControl.isNotEmpty) {
            print(
                "Status: ${patientCubit.listBabyControl[patientCubit.listBabyControl.length - 1].status}");
            statusNutrition = patientCubit
                .listBabyControl[patientCubit.listBabyControl.length - 1]
                .status;
            normalNutrition = patientCubit
                .listBabyControl[patientCubit.listBabyControl.length - 1]
                .normalIndicator;
            lessNutrition = patientCubit
                .listBabyControl[patientCubit.listBabyControl.length - 1]
                .lesslIndicator;
            currentWeight = patientCubit
                .listBabyControl[patientCubit.listBabyControl.length - 1]
                .currentWeight;
          }
        } else if (state is SomeAnalysisBabyLoading) {
          progressDialogFull(context);
        } else if (state is SomeAnalysisBabyLoaded) {
          setState(() {
            chartData.clear();
            String value =
                selectedBaby.beratAnak.replaceAll(RegExp(r'[A-Za-z]'), "");

            chartData.add(ChartData(0, double.parse(value)));

            for (var i = 0; i < patientCubit.listBabyControl.length; i++) {
              final babyControl = patientCubit.listBabyControl[i];
              chartData
                  .add(ChartData(babyControl.umur, babyControl.beratBadan));
            }
            chartData.sort((a, b) => a.x.compareTo(b.x));
          });
          if (patientCubit.listBabyControl.isNotEmpty) {
            print(
                "Status: ${patientCubit.listBabyControl[patientCubit.listBabyControl.length - 1].status}");
            statusNutrition = patientCubit
                .listBabyControl[patientCubit.listBabyControl.length - 1]
                .status;
            normalNutrition = patientCubit
                .listBabyControl[patientCubit.listBabyControl.length - 1]
                .normalIndicator;
            lessNutrition = patientCubit
                .listBabyControl[patientCubit.listBabyControl.length - 1]
                .lesslIndicator;
            currentWeight = patientCubit
                .listBabyControl[patientCubit.listBabyControl.length - 1]
                .currentWeight;
          }

          dismissProgressDialogFull(context);
        }
      },
      child: Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(color: AppColor.primary),
              )
            : patientCubit.listBaby.length == 0
                ? Center(
                    child: Text(
                      "Data Kosong",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.black,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      babyRowChoose(),
                      chartData.length == 1
                          ? emptyBabyGraphic()
                          : babyGraphic(),
                    ],
                  ),
      ),
    );
  }

  Expanded babyGraphic() {
    return Expanded(
      child: Column(
        children: [
          // nutrition graphic
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 12),
                    child: Text(
                      'Berat Badan',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColor.greyFont,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SfCartesianChart(
                      series: <ChartSeries>[
                        // Renders line chart
                        LineSeries<ChartData, double>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                      tooltipBehavior: _tooltipBehavior,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Umur',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColor.greyFont,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  blurStyle: BlurStyle.normal,
                  color: AppColor.black,
                  offset: Offset(0, 0),
                  spreadRadius: 0.1,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      statusNutrition,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: BaseButton(
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    blurStyle: BlurStyle.normal,
                                    color: AppColor.black,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0.1,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 16),
                                    width: 100,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 16, right: 16),
                                    child: TextItemWidget(
                                      title: currentWeight,
                                      text: statusNutrition,
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  // Expanded(child: SizedBox()),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Indikator",
                                      style: TextStyle(
                                        color: AppColor.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: TextItemWidget(
                                        title: "Normal", text: normalNutrition),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: TextItemWidget(
                                        title: "Kekurangan Gizi",
                                        text: lessNutrition),
                                  ),
                                  SizedBox(height: 24),
                                ],
                              ),
                            );
                          });
                    },
                    style: AppButtonStyle.secondary,
                    text: "Detail",
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded emptyBabyGraphic() {
    return Expanded(
      child: Center(
        child: Text(
          "Bayi belum melakukan kontrol",
          style: TextStyle(
            fontSize: 12,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }

  Container babyRowChoose() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nama Anak",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ),
          DropdownButtonFormField<Baby>(
            items: listBabyMenu,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 14,
            ),
            isExpanded: true,
            value: patientCubit.listBaby[0],
            onChanged: (value) {
              setState(() {
                selectedBaby = value!;
              });
              patientCubit.getSomeAnalysisBabyData(widget.patient, value!);
            },
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}
