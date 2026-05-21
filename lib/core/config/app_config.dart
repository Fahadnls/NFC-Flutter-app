import '../../environment/environment.dart';

class AppConfig {
  static String get googleApiKey => GOOGLE_API_KEY.trim();

  static bool get hasGoogleApiKey => googleApiKey.isNotEmpty;
}
