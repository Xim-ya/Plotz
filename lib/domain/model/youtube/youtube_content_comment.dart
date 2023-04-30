import 'dart:math';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.11.23
 *  [YoutubeExplore]로부터 데이터를 매핑
 * */

class YoutubeContentComment {
  final List<String> profileImagePathList = [
    'avatar_1.svg',
    'avatar_2.svg',
    'avatar_3.svg',
    'avatar_4.svg',
    'avatar_5.svg',
    'avatar_6.svg',
    'avatar_7.svg',
    'avatar_8.svg',
    'avatar_9.svg'
  ];

  final String author; // 댓글 작성자 이름
  final String profileImgPath; // Svg 프로필 이미지 path
  final String text; // 댓글 내용
  final bool isHearted; // 채널장 좋아요 여부.

  YoutubeContentComment(
      {required this.author,
      required this.profileImgPath,
      required this.text,
      required this.isHearted,});

  factory YoutubeContentComment.fromResponse(Comment response) {
    final int randomNum = Random().nextInt(9) + 1;
    return YoutubeContentComment(
      author: response.author,
      profileImgPath: 'avatar_$randomNum',
      text: response.text,
      isHearted: response.isHearted,
    );
  }
}
