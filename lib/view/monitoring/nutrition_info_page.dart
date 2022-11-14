part of '../pages.dart';

class NutritionInfoPage extends StatefulWidget {
  const NutritionInfoPage({Key? key}) : super(key: key);

  @override
  State<NutritionInfoPage> createState() => _NutritionInfoPageState();
}

class _NutritionInfoPageState extends State<NutritionInfoPage> {
  bool isNormal = true;
  bool isNotNormal = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Informasi Acuan Gizi",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            _tabInfo(context, () {
              setState(() {
                isNormal = !isNormal;
              });
            }, "Gizi Bayi Normal", isNormal),
            _normalNutrition(),
            SizedBox(height: 16),
            _tabInfo(context, () {
              setState(() {
                isNotNormal = !isNotNormal;
              });
            }, "Kekurangan Gizi", isNotNormal),
            _notNormalNutrition(),
          ],
        ),
      ),
    );
  }

  Widget _normalNutrition() {
    return Visibility(
      visible: isNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextItemWidget(title: "Umur", text: "Berat Badan (Kg)"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(height: 0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: listFieldNormalWeight(),
            ),
          )
        ],
      ),
    );
  }

  Widget _notNormalNutrition() {
    return Visibility(
      visible: isNotNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextItemWidget(title: "Umur", text: "Berat Badan (Kg)"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(height: 0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: listFieldNotNormalWeight(),
            ),
          )
        ],
      ),
    );
  }

  InkWell _tabInfo(
      BuildContext context, Function onTap, String title, bool isExpand) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: AppColor.primary, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Icon(
              isExpand
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_up_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
