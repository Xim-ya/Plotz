import 'package:uppercut_fantube/presentation/screens/search/search_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class DramaSearchedResultsTabView extends BaseView<SearchViewModel> {
  const DramaSearchedResultsTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return ListView.separated(
      padding: AppInset.top20,
      itemCount: 10,
      separatorBuilder: (__, _) => AppSpace.size12,
      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            // 컨텐츠 포스터 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://www.themoviedb.org/t/p/w1280/lxfllsQQ32gKglUxrM61WaFeNcy.jpg',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer(
                    child: Container(
                      color: AppColor.black,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            AppSpace.size8,
            SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppSpace.size2,
                  // 제목
                  Row(
                    children: [
                      Text(
                        '왕좌의 게임',
                        style: AppTextStyle.title1,
                      ),
                      AppSpace.size2,
                      // 컨텐츠 등록 여부
                      SvgPicture.asset('assets/icons/check_box.svg'),
                    ],
                  ),
                  // 개봉 & 첫 방영일
                  Text(
                    Formatter.dateToyyMMdd('2022-11-12'),
                    style: AppTextStyle.body2
                        .copyWith(color: AppColor.lightGrey),
                  ),
                  AppSpace.size2,
                  // 등록 여부 Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset('assets/icons/round_exclamation.svg'),
                      AppSpace.size2,
                      Text(
                        '등록되지 않은 컨텐츠 입니다',
                        style: AppTextStyle.alert2
                            .copyWith(color: const Color(0xFF303030)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
