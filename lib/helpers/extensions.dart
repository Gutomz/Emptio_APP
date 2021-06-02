extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    
    return regex.hasMatch(this);
  }
}
