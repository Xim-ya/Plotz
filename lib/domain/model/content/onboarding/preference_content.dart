/** Created By Ximya - 2023.06.18
 *  온보딩 섹션에서 사용되는
 *  유저 취향 옵션 콘텐츠 모델
 * */

class PreferredContent {
  final String posterImgUrl;
  final String contentId;
  final List<String> genres;

  PreferredContent({
    required this.posterImgUrl,
    required this.contentId,
    required this.genres,
  });

  static List<PreferredContent> get getList => [
        PreferredContent(
          posterImgUrl: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
          contentId: 't-1396',
          genres: ['t-드라마', 't-범죄'],
        ),
        PreferredContent(
          posterImgUrl: '/b4mJz9qvh4i328aIO0Ciqqy2DGA.jpg',
          contentId: 'm-300669',
          genres: ['m-스릴러', 'm-공포'],
        ),
        PreferredContent(
          posterImgUrl: '/5geQcMRFveBXizum8bHkSGu1a31.jpg',
          contentId: 't-60059',
          genres: ['t-범죄', 't-드라마'],
        ),
        PreferredContent(
          posterImgUrl: '/mpOQpOKdo2XJnTqRzo1lTmDNsc1.jpg',
          contentId: 't-66732',
          genres: ['t-드라마', 't-Sci-Fi&Fantasy', 't-미스터리'],
        ),
        PreferredContent(
          posterImgUrl: '/9wOTABT35GsYNHtmFnxbRYN9d24.jpg',
          contentId: 't-82856',
          genres: ['t-Sci-Fi&Fantasy', 't-Action&Adventure', 't-드라마'],
        ),
        PreferredContent(
          posterImgUrl: '/jZy73aPYrwwhuc37ALgnJUCaTnK.jpg',
          contentId: 'm-882569',
          genres: ['m-전쟁', 'm-액션', 'm-스릴러'],
        ),
        PreferredContent(
          posterImgUrl: '/b7epV2cQZVIR4u5VZraDwD0AgiE.jpg',
          contentId: 'm-447365',
          genres: ['m-SF', 'm-모험', 'm-액션'],
        ),
        PreferredContent(
          posterImgUrl: '/kVS51ssZF1y0IXF342h54cIJ0EK.jpg',
          contentId: 'm-916224',
          genres: ['m-애니메이션', 'm-드라마', 'm-모험', 'm-판타지'],
        ),
        PreferredContent(
          posterImgUrl: '/jjHccoFjbqlfr4VGLVLT7yek0Xn.jpg',
          contentId: 'm-496243',
          genres: ['m-코미디', 'm-스릴러', 'm-드라마'],
        ),
        PreferredContent(
          posterImgUrl: '/1F2rDT1oNdvMyXF7gxbGxaXCzrz.jpg',
          contentId: 'm-466272',
          genres: ['m-코미디', 'm-드라마', 'm-스릴러'],
        ),
        PreferredContent(
          posterImgUrl: '/wrCwH6WOvXQvVuqcKNUrLDCDxdw.jpg',
          contentId: 'm-475557',
          genres: ['m-범죄', 'm-드라마', 'm-스릴러'],
        ),
        PreferredContent(
          posterImgUrl: '/ePXuKdXZuJx8hHMNr2yM4jY2L7Z.jpg',
          contentId: 'm-559969',
          genres: ['m-범죄', 'm-드라마', 'm-스릴러', 'm-액션'],
        ),
      ];
}
