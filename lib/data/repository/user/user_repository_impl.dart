import 'package:soon_sak/data/dataSource/user/user_data_source.dart';
import 'package:soon_sak/data/repository/user/user_repository.dart';
import 'package:soon_sak/domain/exception/user/user_exception.dart';
import 'package:soon_sak/domain/model/content/myPage/user_curation_summary.dart';
import 'package:soon_sak/utilities/index.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._dataSource);

  final UserDataSource _dataSource;

  @override
  Future<Result<void>> addUserQurationInfo(
      {required String qurationDocId, required String userId}) async {
    try {
      final response = _dataSource.addUserQurationInfo(
          qurationDocId: qurationDocId, userId: userId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(UserException.updateUserQurationInfoFailed());
    }
  }

  @override
  Future<Result<UserCurationSummary>> loadUserCurationSummary(String userId) async {
    try {
      final response = await _dataSource.loadUserCurationSummary(userId);
      return Result.success(UserCurationSummary.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
