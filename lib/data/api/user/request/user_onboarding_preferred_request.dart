import 'package:soon_sak/data/api/channel/response/channel_response.dart';
import 'package:soon_sak/data/api/user/request/preferred_content_request.dart';

class UserOnboardingPreferredRequest {
  final List<PreferredRequestContent> contents;
  final List<ChannelBasicResponse> channels;

  UserOnboardingPreferredRequest({
    required this.contents,
    required this.channels
  });
}
