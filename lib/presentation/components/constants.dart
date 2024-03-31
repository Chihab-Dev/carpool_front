class PresentationConstances {
  static bool isPhoneNumberValid(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^(06|05|07)[0-9]{8}$');

    return phoneRegex.hasMatch(phoneNumber);
  }
}
