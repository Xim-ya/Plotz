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
      })
      : _contentRepository = contentRepository,
        _userRepository = userRepository;


  final ContentRepository _contentRepository;
  final UserRepository _userRepository;

  @override
  Future<Result<void>> call(ContentRegistrationRequest request) async {
    final response =
    await _contentRepository.requestContentRegistration(request);
    return response.fold(
      onSuccess: (data) async {
        final response = await _userRepository.addUserCurationInfo(
          curationDocId: data,
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
