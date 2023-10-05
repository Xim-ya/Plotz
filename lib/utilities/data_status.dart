/** Created By Ximya - 2023.10.13
 * TODO: DOCUMENTATION 보완 필요
 * 서버로부터 받아온 데이터의 상태를 나태내기 위한 추상 클래스
 * [Presentation] 레이에서 매핑되어 사용됨
 *
 * */

/// Ds ==> DataStatus
abstract class Ds<T> {
  T? get value;

  DataStatus cycle;
  Exception? error;

  Ds({required this.cycle, this.error});
}

///
/// 데이터가 성공적으로 로드된 상태
///
class Fetched<T> extends Ds<T> {
  @override
  final T value;

  Fetched(this.value) : super(cycle: DataStatus.fetched);
}

///
/// 데이터 로딩 중인 상태
///

class Loading<T> extends Ds<T> {
  Loading() : super(cycle: DataStatus.loading);

  @override
  T? get value => null;
}

///
/// 데이터 초기 상태
///

class Initial<T> extends Ds<T> {
  Initial() : super(cycle: DataStatus.initial);

  dynamic tag;

  @override
  T? get value => null;
}

///
/// 데이터 로딩 실패한 상태
///

class Failed<T> extends Ds<T> {
  final Exception error;

  Failed(this.error) : super(cycle: DataStatus.failed, error: error);

  @override
  T? get value => null;
}

///
/// 데이터 사이클
/// loading, fetched, failed 상태로 구분됨
/// TODO: 필요에 따라 initial 상태를 추가해볼 수 있겠음
///
enum DataStatus {
  initial,
  loading,
  fetched,
  failed;

  bool get isLoadingOrInitial =>
      this == DataStatus.initial || this == DataStatus.loading;

  bool get isInitial => this == DataStatus.initial;

  bool get isLoading => this == DataStatus.loading;

  bool get isFetched => this == DataStatus.fetched;

  bool get isFailed => this == DataStatus.failed;
}
