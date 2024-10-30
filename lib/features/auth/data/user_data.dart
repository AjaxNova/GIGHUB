class UserData {
  static final UserData _instance = UserData._internal();

  UserData._internal();

  static UserData getInstance() {
    return _instance;
  }

  String? userId;

  void setUserId(String id) {
    userId = id;
  }
}
