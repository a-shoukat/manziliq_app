class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? required(String? value, [String field = 'This field']) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? cnic(String? value) {
    if (value == null || value.isEmpty) return 'CNIC is required';
    if (!RegExp(r'^\d{5}-\d{7}-\d$').hasMatch(value)) {
      return 'Format: 12345-1234567-1';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone is required';
    if (!RegExp(r'^03\d{9}$').hasMatch(value.replaceAll('-', ''))) {
      return 'Enter valid Pakistani mobile (03XXXXXXXXX)';
    }
    return null;
  }
}
