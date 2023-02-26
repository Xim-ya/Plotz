class UserProfileRequest {
  final String userId;
  final String? photoImgUrl;
  final String? displayName;

  UserProfileRequest({
    required this.photoImgUrl,
    required this.displayName,
    required this.userId,
  });
}
