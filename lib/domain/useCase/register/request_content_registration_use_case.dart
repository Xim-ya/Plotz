import 'dart:developer';
import 'package:soon_sak/data/repository/user/user_repository.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.16
 *
 * */

class RequestContentRegistrationUseCase
    extends BaseUseCase<ContentRequest, Result<void>> {
  RequestContentRegistrationUseCase(this._contentRepository, this._userRepository);

  final ContentRepository _contentRepository;
  final UserRepository _userRepository;

  @override
  Future<Result<void>> call(ContentRequest request) async {
    final response = await _contentRepository.requestContentRegistration(request);
    return response.fold(
      onSuccess: (data) async {
        final response = await _userRepository.addUserQurationInfo(
          qurationDocId: data,
          userId: UserService.to.userInfo!.id!,
        );
        return response.fold(
          onSuccess: (_) {
            return Result.success(null);
          },
          onFailure: Result.failure,
        );
      },
      onFailure: (e) {
        log('RequestContentRegistrationUseCase  : $e');
        return Result.failure(e);
      },
    );
  }
}
