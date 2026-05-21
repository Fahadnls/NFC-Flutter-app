import 'dart:convert';
import 'dart:developer';

import '../../core/utils/consts.dart';
import 'storage_service.dart';

class StorageProvider {
  static late final StorageService _storageService;
  static String? _cachedAccessToken;
  static String? _cachedRefreshToken;
  static Map<String, dynamic> _cachedUserProfile = <String, dynamic>{};
  static const String _profileKey = 'cachedUserProfile';

  static void init(StorageService storageService) {
    _storageService = storageService;
  }

  static Future<void> clearStorage() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    _cachedUserProfile = <String, dynamic>{};
    await _storageService.delete(kUseKey);
    await _storageService.delete(_profileKey);
    await _storageService.clear();
  }

  static Future<void> loadToken() async {
    final userJson = await _storageService.read(kUseKey);
    if (userJson == null) {
      _cachedAccessToken = null;
      _cachedRefreshToken = null;
      return;
    }
    final Map<String, dynamic> jsonMap = jsonDecode(userJson);
    _cachedAccessToken =
        jsonMap['accessToken'] as String? ?? jsonMap['token'] as String?;
    _cachedRefreshToken = jsonMap['refreshToken'] as String?;
    final cachedProfileJson = await _storageService.read(_profileKey);
    if (cachedProfileJson != null && cachedProfileJson.isNotEmpty) {
      try {
        _cachedUserProfile =
            jsonDecode(cachedProfileJson) as Map<String, dynamic>;
      } catch (_) {
        _cachedUserProfile = <String, dynamic>{};
      }
    }
  }

  static String? getAccessToken() => _cachedAccessToken;
  static String? getRefreshToken() => _cachedRefreshToken;

  static Future<void> setToken(String? newToken) async {
    await setTokens(accessToken: newToken, refreshToken: null);
  }

  static Future<void> setTokens({
    required String? accessToken,
    String? refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    _cachedRefreshToken = refreshToken;

    if (accessToken == null && refreshToken == null) {
      await _storageService.delete(kUseKey);
      return;
    }

    final jsonMap = {
      // Keep legacy token key for existing consumers.
      'token': accessToken,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
    final userJson = jsonEncode(jsonMap);
    await _storageService.write(kUseKey, userJson);
  }

  static Future<void> removeToken() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    await _storageService.delete(kUseKey);
  }

  // static Future<void> setCurrentUser(GetUserUserModel user) async {
  //   _cachedUserProfile = {
  //     'name': user.name,
  //     'phone': user.phone,
  //     'profile': user.profile,
  //     'gender': user.gender,
  //     'birthDate': user.birthDate.toIso8601String(),
  //   };
  //   await _storageService.write(_profileKey, jsonEncode(_cachedUserProfile));
  // }

  static Future<void> mergeCurrentUser({
    String? name,
    String? phone,
    String? profile,
    String? gender,
    String? birthDate,
  }) async {
    _cachedUserProfile = {
      ..._cachedUserProfile,
      'name': name ?? _cachedUserProfile['name'],
      'phone': phone ?? _cachedUserProfile['phone'],
      'profile': profile ?? _cachedUserProfile['profile'],
      'gender': gender ?? _cachedUserProfile['gender'],
      'birthDate': birthDate ?? _cachedUserProfile['birthDate'],
    };
    await _storageService.write(_profileKey, jsonEncode(_cachedUserProfile));
  }

  static const String _langKey = 'appLanguageCode';
  static const String _themeModeKey = 'appThemeMode';
  static const String _guestModeKey = 'isGuestMode';
  // Set the current language code
  static Future<void> setCurrentLanguage(String languageCode) async {
    await _storageService.write(_langKey, languageCode);
  }

  static Future<String?> getCurrentLanguageCode() async {
    final savedCode = await _storageService.read(_langKey);
    log("language tag : Saved language code = $savedCode");
    return savedCode;
  }

  static Future<void> setThemeMode(String themeMode) async {
    await _storageService.write(_themeModeKey, themeMode);
  }

  static Future<String?> getThemeMode() async {
    final savedThemeMode = await _storageService.read(_themeModeKey);
    log("theme mode : Saved theme mode = $savedThemeMode");
    return savedThemeMode;
  }

  static Future<void> setGuestMode(bool isGuest) async {
    await _storageService.write(_guestModeKey, isGuest.toString());
  }

  static Future<bool> isGuestMode() async {
    final value = await _storageService.read(_guestModeKey);
    return value == 'true';
  }

  static Map<String, dynamic>? _getPayloadMap() {
    final token = _cachedAccessToken;
    if (token == null) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final Map<String, dynamic> payloadMap = jsonDecode(payload);
      log("token payload: $payloadMap");
      return payloadMap;
    } catch (e) {
      return null;
    }
  }

  static String? getUserId() {
    final payload = _getPayloadMap();
    return payload?['_id']?.toString();
  }

  static String? getEmail() {
    final payload = _getPayloadMap();
    return payload?['email']?.toString();
  }

  static String? getPhone() {
    final cachedPhone = _cachedUserProfile['phone']?.toString();
    if (cachedPhone != null && cachedPhone.trim().isNotEmpty) {
      return cachedPhone.trim();
    }
    final payload = _getPayloadMap();
    return payload?['phone']?.toString();
  }

  static String? getProfilePhoto() {
    final cachedProfile = _cachedUserProfile['profile']?.toString();
    if (cachedProfile != null && cachedProfile.trim().isNotEmpty) {
      return cachedProfile.trim();
    }
    final payload = _getPayloadMap();
    return payload?['picture']?.toString() ??
        payload?['profilePhoto']?.toString() ??
        payload?['avatar']?.toString() ??
        payload?['image']?.toString();
  }

  static String? getName() {
    final cachedName = _cachedUserProfile['name']?.toString();
    if (cachedName != null && cachedName.trim().isNotEmpty) {
      return cachedName.trim();
    }
    final payload = _getPayloadMap();
    return payload?['name']?.toString();
  }

  static String? getGender() {
    final cachedGender = _cachedUserProfile['gender']?.toString();
    if (cachedGender != null && cachedGender.trim().isNotEmpty) {
      return cachedGender.trim();
    }
    final payload = _getPayloadMap();
    return payload?['gender']?.toString();
  }

  static String? getBirthDate() {
    final cachedBirthDate = _cachedUserProfile['birthDate']?.toString();
    if (cachedBirthDate != null && cachedBirthDate.trim().isNotEmpty) {
      return cachedBirthDate.trim();
    }
    final payload = _getPayloadMap();
    return payload?['birthDate']?.toString();
  }

  static String? getRegion() {
    final payload = _getPayloadMap();
    return payload?['region']?.toString();
  }

  static String? lastUpdated() {
    final payload = _getPayloadMap();
    return payload?['updatedAt']?.toString();
  }

  static bool isActive() {
    final payload = _getPayloadMap();
    return payload?['is_active'] ?? false;
  }

  static int currentAOQ() {
    final payload = _getPayloadMap();
    return payload?['aoq_current'] ?? false;
  }

  static String? getStripeCustomerId() {
    final payload = _getPayloadMap();
    return payload?['stripeCustomerId'] ?? "";
  }

  static String? getLangugae() {
    final payload = _getPayloadMap();
    return payload?['language'] ?? "en";
  }

  static String? getPhoneNo() {
    final payload = _getPayloadMap();
    return payload?['phone']?.toString();
  }
}
