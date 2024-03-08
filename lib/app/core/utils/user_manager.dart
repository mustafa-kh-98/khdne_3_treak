import '../../data/remote/models/auth_models/response/user_response.dart';
import '../utils/app_storage.dart';

class UserManager {
  static final manager = UserManager._();

  UserManager._();

  factory UserManager() => manager;

  bool get isLoggedIn => AppStorage.read(AppStorage.IS_LOGGED_IN) ?? false;

  bool get isShowIntro => AppStorage.read(AppStorage.IS_SHOW_INTRO) ?? false;

  String get token => AppStorage.read(AppStorage.TOKEN_KEY) ?? '';

  User? get user => AppStorage.read(AppStorage.USER) == null
      ? null
      : User.fromJson(AppStorage.read(AppStorage.USER));

  login(UserResponseDto data) {
    AppStorage.write(AppStorage.IS_LOGGED_IN, true);
    AppStorage.write(AppStorage.USER, data.user!.toJson());
    AppStorage.write(AppStorage.TOKEN_KEY, data.token);
  }
}
