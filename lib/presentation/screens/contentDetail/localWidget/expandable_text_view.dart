import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.24
 *  텍스트의 Expansion (더보기 & 접기) 기능을 지원하는 View
 *  [TextPainter]을 통해 현재 화면에 그려진 Text는 라인 개수를 측정하고
 *  예외처리 할 수 있도록 함.
 * */

class ExpandableTextView extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableTextView(
      {super.key, required this.text, required this.maxLines,});

  @override
  _ExpandableTextViewState createState() => _ExpandableTextViewState();
}

class _ExpandableTextViewState extends State<ExpandableTextView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final TextPainter textPainter = TextPainter(
          text: TextSpan(text: widget.text),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final bool isTextOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.text,
              style: AppTextStyle.title1
                  .copyWith(fontFamily: 'pretendard_regular'),
              maxLines: isExpanded ? null : widget.maxLines,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            if (isTextOverflowing)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    isExpanded ? '접기' : '더보기',
                    style:
                        AppTextStyle.body3.copyWith(color: AppColor.lightGrey),
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
