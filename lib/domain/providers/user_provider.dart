import '../../data/models/user_model.dart';

abstract class UserProvider {
  Future<UserModel?> getUser();
  Future<void> setUser(UserModel userModel);
  Future<void> clearUser();
  Future<void> updateAccessToken(String newAccessToken);
  Stream<UserModel?> get userStream;
}
