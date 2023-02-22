
class JsonResponse {
  final Map<String, dynamic> json;

  JsonResponse(this.json);

  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    return JsonResponse(json);
  }
}
