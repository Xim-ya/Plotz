enum CurationStatus {
  completed,
  inProgress,
  onHold;



  factory CurationStatus.fromOriginString(String originId) {
    switch (originId) {
      case 'completed':
        return CurationStatus.completed;
      case 'inProgress':
        return CurationStatus.inProgress;
      case 'onHold' :
        return CurationStatus.onHold;
      default:
        throw Exception('Sns Enum : enum not found');
    }
  }
}