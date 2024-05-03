
extension StringExtension on String {
  String capitalizeFirstCharacter() {
    return this[0].toUpperCase() + substring(1);
  }

  String capitalizeEachWord() {
    return split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return '';
    }).join(' ');
  }
}