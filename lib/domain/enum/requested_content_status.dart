/** Created By Ximya - 2023.10.02
 *  등록되지 않은 콘텐츠를 유저가 검색할 때
 *  구분되는 상태 타입
 *
 * */

enum RequestedContentStatus {
  waiting(0, '신청', null), // 등록 대기 중
  registered(1, '완료', null), // 등록 완료
  pendingInappropriate(2, '보류', '요약된 콘텐츠가 없습니다'), // 적합하지 않은 콘텐츠
  pendingNoSummary(2, '보류', '적합하지 않은 콘텐츠 입니다'); // 서머리 콘텐츠가 존재 하지 않음

  final int key;
  final String text;
  final String? desc;

  factory RequestedContentStatus.fromKeyValue(
      {required int key, String? pendingReason}) {
    switch ((key, pendingReason)) {
      case (0, null):
        return RequestedContentStatus.waiting;
      case (1, null):
        return RequestedContentStatus.registered;
      case (2, 'inappropriate'):
        return RequestedContentStatus.pendingInappropriate;
      case (2, 'noSummaryContent'):
        return RequestedContentStatus.pendingNoSummary;
      case (2, null):
        return RequestedContentStatus.pendingInappropriate;
      default:
        throw Exception('요청된 콘텐츠 타입 매칭 실패');
    }
  }

  const RequestedContentStatus(this.key, this.text, this.desc);
}
