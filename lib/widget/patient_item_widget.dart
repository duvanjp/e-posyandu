part of 'widgets.dart';

class PatientItemWidget extends StatelessWidget {
  const PatientItemWidget({
    Key? key,
    required this.dataPatient,
    this.isNavigate = true,
    required this.onTap,
  }) : super(key: key);

  final Patient dataPatient;
  final bool isNavigate;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isNavigate) {
          onTap();
        }
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    border: Border.all(color: AppColor.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.darkGrey,
                  ),
                  child: Text(
                    GlobalHelper.getInitials(dataPatient.namaIbu),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            dataPatient.namaIbu,
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
                            dataPatient.noTelp,
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
                isNavigate
                    ? SizedBox()
                    : BaseButton(
                        style: AppButtonStyle.secondary,
                        radius: 8,
                        text: "Detail",
                        onPressed: () {
                          onTap();
                        },
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
