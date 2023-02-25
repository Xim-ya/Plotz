import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.25
 *  정규식 표현 기반 필터링 로직
 *
 *
 *  [hasContainFWord]
 *  닉네임 설정을 할 때 비속어 및 욕설을 제한하기 위한 필터링 로직
 *  정규식 출처 : https://github.com/curioustorvald/KoreanCursewordRegex
 * */

class Regex {
  // 공백 존재 여부
  static bool hasSpaceOnString(String value) {
    return RegExp(r'\s').hasMatch(value.trim()) || value.getLastCharacter == ' '
        ? true
        : false;
  }

  /// 적합한 문자 사용 여부
  /// 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있음
  static bool hasProperCharacter(String value) {
    return !RegExp(r'^[a-zA-Z0-9ㄱ-ㅎ가-힣_-]+$').hasMatch(value.trim());
  }

  static bool hasContainFWord(String value) {
    return RegExp(
            r'시발|병신|[시씨슈쓔쉬쉽쒸쓉]([0-9]*|[0-9]+ *)[바발벌빠빡빨뻘파팔펄]|[섊좆좇졷좄좃좉졽썅춍]|ㅅㅣㅂㅏㄹ?|ㅂ[0-9]*ㅅ|[ㅄᄲᇪᄺᄡᄣᄦᇠ]|[ㅅㅆᄴ][0-9]*[ㄲㅅㅆᄴㅂ]|[존좉좇][0-9 ]*나|[자보][0-9]+지|보빨|[봊봋봇봈볻봁봍] *[빨이]|[후훚훐훛훋훗훘훟훝훑][장앙]|후빨|[엠앰]창|애[미비]|애자|[^탐]색기|([샊샛세쉐쉑쉨쉒객갞갟갯갰갴겍겎겏겤곅곆곇곗곘곜걕걖걗걧걨걬] *[끼키퀴])|새 *[키퀴]|[병븅]신|미친[가-닣닥-힣]|[믿밑]힌|[염옘]병|[샊샛샜샠섹섺셋셌셐셱솃솄솈섁섂섓섔섘]기|[섹섺섻쎅쎆쎇쎽쎾쎿섁섂섃썍썎썏][스쓰]|지랄|니[애에]미|갈[0-9]*보[^가-힣]|[뻐뻑뻒뻙뻨][0-9]*[뀨큐킹낑)|꼬추|곧휴|[가-힣]슬아치|자박꼼|[병븅]딱|빨통|[사싸](이코|가지|까시)|육시[랄럴]|육실[알얼할헐]|즐[^가-힣]|찌(질이|랭이)|찐따|찐찌버거|창[녀놈]|[가-힣]{2,}충[^가-힣]|[가-힣]{2,}츙|부녀자|화냥년|환[양향]년|호[구모]|조[선센][징]|조센|[쪼쪽쪾]([발빨]이|[바빠]리)|盧|무현|찌끄[레래]기|(하악){2,}|하[앍앜]|[낭당랑앙항남담람암함][ ]?[가-힣]+[띠찌]|느[금급]마|文在|在寅|(?<=[^\n])[家哥]|속냐|[tT]l[qQ]kf|Wls')
        .hasMatch(value.trim());
  }

  static bool hasContainOperationWord(String value) {
    return RegExp('운영자|관리자').hasMatch(value.trim());
  }
}
