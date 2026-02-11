class Valid {
  Valid._();

  static final nickname = RegExp(r'^[가-힣]{4,12}$');

  static bool isBirthDate(String birth) {
    if (birth.isEmpty || birth.length != 10) return false;

    try {
      final parts = birth.split('.');
      if (parts.length != 3) return false;

      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      if (month < 1 || month > 12) return false;
      if (day < 1 || day > 31) return false;

      final birthDateTime = DateTime(year, month, day);
      if (birthDateTime.isAfter(DateTime.now())) return false;

      return true;
    } catch (e) {
      return false;
    }
  }
}
