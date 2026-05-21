import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import '../../core/utils/consts.dart';
import '../../data/models/user_model.dart';
import 'storage_service.dart';
import 'user_provider.dart';

class UserProviderImpl implements UserProvider {
  final StorageService _storageService;
  final StreamController<UserModel?> _controller =
      StreamController<UserModel?>.broadcast();

  static const String _key = kUseKey;

  UserProviderImpl({required StorageService storageService})
    : _storageService = storageService {
    log('🔧 UserProviderImpl initialized with key: $_key');
  }

  @override
  Future<void> clearUser() async {
    await _storageService.delete(_key);
    _controller.add(null);
    log('🧹 User data cleared from storage');
  }

  @override
  Future<void> setUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _storageService.write(_key, userJson);
    _controller.add(user);
  }

  @override
  Future<void> updateAccessToken(String newAccessToken) async {
    final user = await getUser();
    if (user != null) {
      final updatedUser = user.copyWith(accessToken: newAccessToken);
      await setUser(updatedUser);
    } else {}
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = await _storageService.read(_key);
    if (userJson == null) {
      log('❌ No user found in storage');
      return null;
    }
    final Map<String, dynamic> userMap = jsonDecode(userJson);
    final user = UserModel.fromJson(userMap);
    // log('📦 Retrieved user from storage: ${user.toJson()}');
    // log('🔑 Retrieved Access Token: ${user.accessToken}');
    return user;
  }

  @override
  Stream<UserModel?> get userStream => _controller.stream;
}
