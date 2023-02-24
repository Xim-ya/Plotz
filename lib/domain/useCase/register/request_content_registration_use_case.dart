import 'dart:developer';
import 'package:soon_sak/data/repository/user/user_repository.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.16
 *
 * */

class RequestContentRegistrationUseCase
    extends BaseUseCase<ContentRegistrationRequest, Result<void>> {
  RequestContentRegistrationUseCase(this._contentRepository, this._userRepository, this._userService);

  final ContentRepository _contentRepository;
  final UserRepository _userRepository;
  final UserService _userService;

  @override
  Future<Result<void>> call(ContentRegistrationRequest request) async {
    final response = await _contentRepository.requestContentRegistration(request);
    return response.fold(
      onSuccess: (data) async {
        final response = await _userRepository.addUserQurationInfo(
          qurationDocId: data,
          userId: _userService.userInfo!.id!,
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
