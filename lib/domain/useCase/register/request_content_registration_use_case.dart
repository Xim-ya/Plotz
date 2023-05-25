import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.16
 *
 * */

class RequestContentRegistrationUseCase
    extends BaseUseCase<ContentRegistrationRequest, Result<void>> {
  RequestContentRegistrationUseCase(
      {required ContentRepository contentRepository,
      required UserRepository userRepository,
      required UserService userService})
      : _contentRepository = contentRepository,
        _userRepository = userRepository,
        _userService = userService;

  final ContentRepository _contentRepository;
  final UserRepository _userRepository;
  final UserService _userService;

  @override
  Future<Result<void>> call(ContentRegistrationRequest request) async {
    final response =
        await _contentRepository.requestContentRegistration(request);
    return response.fold(
      onSuccess: (data) async {
        final response = await _userRepository.addUserCurationInfo(
          qurationDocId: data,
          userId: _userService.userInfo.value.id!,
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
