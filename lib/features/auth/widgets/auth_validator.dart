class AuthValidator {
  /// Định dạng email đúng
  /// Rules:
  /// - Phải có dạng @gmail.com
  /// - Phải có ít nhất 2 ký tự trước @
  static bool validateEmail(String email) {
    if (email.isEmpty) {
      return false;
    }

    if (!email.endsWith('@gmail.com')) {
      return false;
    }

    final localPart = email.substring(0, email.indexOf('@'));
    if (localPart.length < 2) {
      return false;
    }

    return true;
  }

  /// Get email error message
  static String? getEmailError(String email) {
    if (email.isEmpty) {
      return null;
    }

    if (!email.endsWith('@gmail.com') || email.indexOf('@') < 2) {
      return 'Vui lòng nhập đúng định dạng email';
    }

    return null;
  }

  /// Định dạng mật khẩu đúng
  /// Rules:
  /// - Ít nhất 6 ký tự
  /// - Ít nhất 1 chữ hoa (A-Z)
  /// - Ít nhất 1 chữ thường (a-z)
  /// - Ít nhất 1 chữ số (0-9)
  static bool validatePassword(String password) {
    if (password.isEmpty) {
      return false;
    }

    if (password.length < 6) {
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    return true;
  }

  /// Get password error message
  static String? getPasswordError(String password) {
    if (password.isEmpty) {
      return null;
    }

    if (password.length < 6 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]'))) {
      return 'Vui lòng nhập mật khẩu có ít nhất 6 kí tự, chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 số';
    }

    return null;
  }
}
