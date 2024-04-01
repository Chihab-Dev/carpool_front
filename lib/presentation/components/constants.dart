class PresentationConstances {
  static bool isPhoneNumberValid(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^(06|05|07)[0-9]{8}$');

    return phoneRegex.hasMatch(phoneNumber);
  }

  static bool isPasswordValid(String password) {
    final RegExp passwordRegex = RegExp(r'^[\w!@#$%^&*()-+=]{7,20}$');
    return passwordRegex.hasMatch(password);
  }

  static bool isNameValid(String name) {
    final RegExp nameRegex = RegExp(r'^[a-zA-Z\s\-]{5,15}$');
    return nameRegex.hasMatch(name);
  }
}
