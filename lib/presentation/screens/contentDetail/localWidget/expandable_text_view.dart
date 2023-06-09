import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.24
 *  텍스트의 Expansion (더보기 & 접기) 기능을 지원하는 View
 *  [TextPainter]을 통해 현재 화면에 그려진 Text는 라인 개수를 측정하고
 *  예외처리 할 수 있도록 함.
 * */

class ExpandableTextView extends StatefulWidget {
  final String text;
  final int maxLines;
  final bool isLoading;

  const ExpandableTextView(
      {super.key,
      required this.text,
      required this.maxLines,
      this.isLoading = false});

  factory ExpandableTextView.createSkeleton() => const ExpandableTextView(
        text: '',
        maxLines: 3,
        isLoading: true,
      );

  @override
  _ExpandableTextViewState createState() => _ExpandableTextViewState();
}

class _ExpandableTextViewState extends State<ExpandableTextView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading == true) {
      return Column(
        children: const [
          SkeletonBox(
            padding: AppInset.vertical6,
            height: 14,
            width: double.infinity,
          ),
          SkeletonBox(
            padding: AppInset.vertical6,
            height: 14,
            width: double.infinity,
          ),
          SkeletonBox(
            padding: AppInset.vertical6,
            height: 14,
            width: double.infinity,
          ),
          SizedBox(
            height: 21,
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final TextPainter textPainter = TextPainter(
          text: TextSpan(text: widget.text),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final bool isTextOverflowing = textPainter.didExceedMaxLines;

        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 21),
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontFamily: 'pretender_regular',
                  fontSize: 12,
                  height: 1.8,
                  letterSpacing: -0.2,
                  color: Colors.white,
                ),
                maxLines: isExpanded ? null : widget.maxLines,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
            ),
            if (isTextOverflowing)
              AnimatedPositioned(
                  right: 0,
                  bottom: isExpanded ? 0 : 21,
                  duration: const Duration(milliseconds: 80),
                  child: Container(
                    height: 21,
                    padding:
                        AppInset.vertical1 + const EdgeInsets.only(left: 30),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(15, 15, 15, 0),
                          Color.fromRGBO(15, 15, 15, 1),
                          Color.fromRGBO(15, 15, 15, 1),
                        ],
                        stops: [0, 0.36, 1],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        minWidth: 0,
                        height: 0,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded ? '접기' : '더보기',
                          style: AppTextStyle.alert1
                              .copyWith(color: AppColor.main),
                        ),
                      ),
                    ),
                  )),
          ],
        );
      },
    );
  }
}
