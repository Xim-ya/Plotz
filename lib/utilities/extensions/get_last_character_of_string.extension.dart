extension StringExtenstion on String {
  String get getLastCharacter {
    if(this.length > 1) {
      return this.substring(this.length - 1, this.length);
    } else {
      return '';
    }

  }
}
