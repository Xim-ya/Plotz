import 'dart:io';

/** Created By Ximya - 2022.12.31
 *  컨텐츠의 비디오(유트브) 포맷에 따라 [ContentVideoFormat]이 나누어짐.
 *  예를들어 '영화'컨텐츠 비디오의 경우
 *  하나의 컨텐츠를 1부, 2부로 나누어지는 경우도 있음
 *  ex)
 *  어몽어스 1부 https://www.youtube.com/watch?v=Wt4JMnuPh4g&t=2s
 *  어몽어스 2부 https://www.youtube.com/watch?v=20k9NtxTY-Y&t=1s
 *  반대로 하나의 컨텐츠 전체를 하나의 비디오(유튜브)로 구성되어 있기도 함.
 *
 *  '드라마'의 경우
 *  시즌1, 시즌2, ... 로 나누어지는 비디오 컨텐츠가 존재
 *
 *  이런 비디오의 타입을 구분하기 위함 enum임
 * */

enum ContentVideoFormat {
  singleMovie,
  multipleMovie,
  singleDrama,
  multipleDrama,
}
