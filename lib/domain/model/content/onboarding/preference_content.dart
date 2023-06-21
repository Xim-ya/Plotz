/** Created By Ximya - 2023.06.18
 *  온보딩 섹션에서 사용되는
 *  유저 취향 옵션 콘텐츠 모델
 * */

class PreferenceContent {
  final String posterImgUrl;
  final String contentId;
  final List<String> genres;

  PreferenceContent({
    required this.posterImgUrl,
    required this.contentId,
    required this.genres,
  });

  static List<PreferenceContent> get getList => [
        PreferenceContent(
          posterImgUrl: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
          contentId: 't-1396',
          genres: ['드라마', '범죄'],
        ),
        PreferenceContent(
          posterImgUrl: '/b4mJz9qvh4i328aIO0Ciqqy2DGA.jpg',
          contentId: 'm-300669',
          genres: ['스릴러', '공포'],
        ),
        PreferenceContent(
          posterImgUrl: '/5geQcMRFveBXizum8bHkSGu1a31.jpg',
          contentId: 't-60059',
          genres: ['범죄', '드라마'],
        ),
        PreferenceContent(
          posterImgUrl: '/mpOQpOKdo2XJnTqRzo1lTmDNsc1.jpg',
          contentId: 't-66732',
          genres: ['드라마', 'Sci-Fi & Fantasy', '미스터리'],
        ),
        PreferenceContent(
          posterImgUrl: '/9wOTABT35GsYNHtmFnxbRYN9d24.jpg',
          contentId: 't-82856',
          genres: ['Sci-Fi & Fantasy', 'Action & Adventure', '드라마'],
        ),
        PreferenceContent(
          posterImgUrl: '/jZy73aPYrwwhuc37ALgnJUCaTnK.jpg',
          contentId: 'm-882569',
          genres: ['전쟁', '액션', '스릴러'],
        ),
        PreferenceContent(
          posterImgUrl: '/b7epV2cQZVIR4u5VZraDwD0AgiE.jpg',
          contentId: 'm-447365',
          genres: ['SF', '모험', '액션'],
        ),
        PreferenceContent(
          posterImgUrl: '/kVS51ssZF1y0IXF342h54cIJ0EK.jpg',
          contentId: 'm-916224',
          genres: ['애니메이션', '드라마', '모험', '판타지'],
        ),
        PreferenceContent(
          posterImgUrl: '/jjHccoFjbqlfr4VGLVLT7yek0Xn.jpg',
          contentId: 'm-496243',
          genres: ['코미디', '스릴러', '드라마'],
        ),
        PreferenceContent(
          posterImgUrl: '/1F2rDT1oNdvMyXF7gxbGxaXCzrz.jpg',
          contentId: 'm-466272',
          genres: ['코미디', '드라마', '스릴러'],
        ),
        PreferenceContent(
          posterImgUrl: '/wrCwH6WOvXQvVuqcKNUrLDCDxdw.jpg',
          contentId: 'm-475557',
          genres: ['범죄', '드라마', '스릴러'],
        ),
        PreferenceContent(
          posterImgUrl: '/ePXuKdXZuJx8hHMNr2yM4jY2L7Z.jpg',
          contentId: 'm-559969',
          genres: ['범죄', '드라마', '스릴러', '액션'],
        ),
      ];
}
