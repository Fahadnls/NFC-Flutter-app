class JsonHelper {
  static String parseString(dynamic value) {
    if (value is String) return value;
    if (value == null) return '';
    return value.toString();
  }

  static int parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static bool parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1';
    }
    if (value is int) return value != 0;
    return false;
  }

  static DateTime parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.fromMillisecondsSinceEpoch(0);
      }
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  static Map<String, dynamic> parseMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return {};
  }

  static List<T> parseList<T>(dynamic value) {
    if (value is List<T>) return value;
    if (value is List) {
      try {
        return value.cast<T>();
      } catch (_) {
        return <T>[];
      }
    }
    return <T>[];
  }

  static List<String> parseStringList(dynamic value) {
    if (value is List<String>) return value;
    if (value is List) {
      return value.map((e) => parseString(e)).toList();
    }
    return <String>[];
  }

  static List<int> parseIntList(dynamic value) {
    if (value is List<int>) return value;
    if (value is List) {
      return value.map((e) => parseInt(e)).toList();
    }
    return <int>[];
  }

  static List<double> parseDoubleList(dynamic value) {
    if (value is List<double>) return value;
    if (value is List) {
      return value.map((e) => parseDouble(e)).toList();
    }
    return <double>[];
  }
}
