part of 'widgets.dart';

class TextItemWidget extends StatefulWidget {
  final String title;
  final String text;
  final bool isPass;
  const TextItemWidget(
      {Key? key, required this.title, required this.text, this.isPass = false})
      : super(key: key);

  @override
  State<TextItemWidget> createState() => _TextItemWidgetState();
}

class _TextItemWidgetState extends State<TextItemWidget> {
  bool isShowed = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.title,
              // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.isPass
                        ? isShowed
                            ? widget.text
                                .replaceRange(0, widget.text.length, "*******")
                            : widget.text
                        : widget.text,
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                widget.isPass
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isShowed = !isShowed;
                          });
                        },
                        child: Icon(
                          isShowed ? Icons.visibility : Icons.visibility_off,
                          color: AppColor.primary,
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
