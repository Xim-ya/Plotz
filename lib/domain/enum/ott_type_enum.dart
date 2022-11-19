enum OttType {
  netflix,
  amazonPrime,
  watcha,
  apple;

  factory OttType.fromString(String originStr) {
    switch (originStr) {
      case 'netflix':
        return OttType.netflix;
      case 'amazonPrime':
        return OttType.amazonPrime;
      case 'watcha':
        return OttType.watcha;
      case 'apple':
        return OttType.apple;
      default:
        throw Exception('enum not found');
    }
  }
}

