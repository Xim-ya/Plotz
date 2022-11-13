import 'package:uppercut_fantube/presentation/common/round_profile_img.dart';
import 'package:uppercut_fantube/presentation/common/video_thumbnail_img_with_player_btn.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_view_model.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/localWidget/section_title.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SingleEpisodeContentTabView extends BaseView<ContentDetailViewModel> {
  const SingleEpisodeContentTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(title: '컨텐츠'),
          // 유튜브 컨텐츠 영상 썸네일
          VideoThumbnailImgWithPlayerBtn(
              onPlayerBtnClicked: () {},
              posterImgUrl:
                  'https://i.ytimg.com/vi/TXMtLF5OANI/maxresdefault.jpg'),
          AppSpace.size4,
          // 좋아요 & 조회수 & 업로드 일자
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Opacity(
                      opacity: 1,
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    AppSpace.size4,
                    Text(
                      '8.8천',
                      style: AppTextStyle.body3,
                    )
                  ],
                ),
                Text(
                  '조회수 80만회 · 3주전',
                  style: AppTextStyle.body3,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Opacity(
              opacity: 0.6,
              child: Text(
                '2022.08.11 기준',
                style: AppTextStyle.body3,
              ),
            ),
          ),
          AppSpace.size40,
          const SectionTitle(title: '설명'),
          Text(
            '수십 년 전 잠적한 전직 CIA 요원 댄 체이스. 과거의 비밀을 안고 은둔한 채 살아가던 중 결국 정체가 탄로 난다. 하지만 미래를 위해서 더 이상 숨어 살 수 없는 그는 과거의 매듭을 풀고자 하는데.',
            style:
                AppTextStyle.title1.copyWith(fontFamily: 'pretendard_regular'),
          ),
          AppSpace.size40,
          // 댓글 - 유튜브 댓글
          const SectionTitle(title: '댓글'),
          ListView.separated(
            separatorBuilder: (__, _) => AppSpace.size12,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const RoundProfileImg(
                  size: 38,
                  imgUrl:
                      'https://yt3.ggpht.com/ytc/AMLnZu9mx97jp2uus8qYKYO7gROx18AWIzQprpRdfLIirP19g4qk25l5_ulscs2AWIte2FTnWYE=s48-c-k-c0x00ffffff-no-rj',
                ),
                AppSpace.size8,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '라람',
                        style: AppTextStyle.body1.copyWith(color: Colors.white),
                      ),
                      Text(
                        '상속자들 붐업, 상속자들 붐업 , 상속자들 붐업 상속자들 붐업, 상속자들 붐업 , 상속자들 붐업',
                        style: AppTextStyle.body1
                            .copyWith(fontFamily: 'pretendard_regular'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
